import Foundation
import Services
import UIKit
import DeepLinks

@MainActor
final class SpaceShareViewModel: ObservableObject {
    
    private enum Constants {
        static let participantLimit = 11 // 10 participants and 1 owner
    }
    
    private let participantSubscriptionService: ParticipantsSubscriptionBySpaceServiceProtocol
    private let workspaceService: WorkspaceServiceProtocol
    private let activeWorkspaceStorage: ActiveWorkpaceStorageProtocol
    private let deppLinkParser: DeepLinkParserProtocol
    
    private var participants: [Participant] = []
    
    @Published var rows: [SpaceShareParticipantViewModel] = []
    @Published var inviteLink: URL?
    @Published var shareInviteLink: URL?
    @Published var limitTitle: String = ""
    @Published var allowToAddMembers = false
    @Published var toastBarData: ToastBarData = .empty
    @Published var requestAlertModel: SpaceRequestViewModel?
    @Published var changeAccessAlertModel: SpaceChangeAccessViewModel?
    @Published var removeParticipantAlertModel: SpaceParticipantRemoveViewModel?
    
    init(
        participantSubscriptionService: ParticipantsSubscriptionBySpaceServiceProtocol,
        workspaceService: WorkspaceServiceProtocol,
        activeWorkspaceStorage: ActiveWorkpaceStorageProtocol,
        deppLinkParser: DeepLinkParserProtocol
    ) {
        self.participantSubscriptionService = participantSubscriptionService
        self.workspaceService = workspaceService
        self.activeWorkspaceStorage = activeWorkspaceStorage
        self.deppLinkParser = deppLinkParser
        startSubscriptions()
        Task {
            let invite = try await workspaceService.generateInvite(spaceId: activeWorkspaceStorage.workspaceInfo.accountSpaceId)
            inviteLink = deppLinkParser.createUrl(deepLink: .invite(cid: invite.cid, key: invite.fileKey), scheme: .main)
        }
    }
    
    func onUpdateLink() {
        Task {
            let invite = try await workspaceService.generateInvite(spaceId: activeWorkspaceStorage.workspaceInfo.accountSpaceId)
            inviteLink = deppLinkParser.createUrl(deepLink: .invite(cid: invite.cid, key: invite.fileKey), scheme: .main)
        }
    }
    
    func onShareInvite() {
        shareInviteLink = inviteLink
    }
    
    func onCopyLink() {
        UIPasteboard.general.string = inviteLink?.absoluteString
        toastBarData = ToastBarData(text: Loc.copied, showSnackBar: true)
    }
    
    // MARK: - Private
    
    private func startSubscriptions() {
        Task {
            await participantSubscriptionService.startSubscription(mode: .owner) { [weak self] items in
                self?.updateParticipant(items: items)
            }
        }
    }
    
    private func updateParticipant(items: [Participant]) {
        participants = items.sorted { $0.sortingWeight > $1.sortingWeight }
        rows = participants.map { participant in
            SpaceShareParticipantViewModel(
                id: participant.id,
                icon: participant.icon?.icon,
                name: participant.name,
                status: participantStatus(participant),
                action: participantAction(participant),
                contextActions: participantContextActions(participant)
            )
        }
        let limit = Constants.participantLimit - items.count
        allowToAddMembers = Constants.participantLimit > items.count
        limitTitle = allowToAddMembers ? Loc.SpaceShare.Invite.members(limit) : Loc.SpaceShare.Invite.maxLimit(Constants.participantLimit)
    }
    
    private func participantStatus(_ participant: Participant) -> SpaceShareParticipantViewModel.Status? {
        switch participant.status {
        case .active:
            return .active(permission: participant.permission.title)
        case .joining:
            return .joining
        case .removing:
            return .removing
        case .declined, .canceled, .removed, .UNRECOGNIZED:
            return nil
        }
    }
    
    private func participantAction(_ participant: Participant) -> SpaceShareParticipantViewModel.Action? {
        switch participant.status {
        case .joining:
            return SpaceShareParticipantViewModel.Action(title: Loc.SpaceShare.Action.viewRequest, action: { [weak self] in
                self?.showRequestAlert(participant: participant)
            })
        case .removing:
            return SpaceShareParticipantViewModel.Action(title: Loc.SpaceShare.Action.approve, action: { [weak self] in
                try await self?.workspaceService.participantRemove(spaceId: participant.spaceId, identity: participant.identity)
            })
        case .active, .canceled, .declined, .removed, .UNRECOGNIZED:
            return nil
        }
    }
    
    private func participantContextActions(_ participant: Participant) -> [SpaceShareParticipantViewModel.ContextAction] {
        guard participant.permission != .owner, participant.status == .active else { return [] }
        return [
            SpaceShareParticipantViewModel.ContextAction(
                title: Loc.SpaceShare.Permissions.reader,
                isSelected: participant.permission == .reader,
                destructive: false,
                action: { [weak self] in
                    self?.showPermissionAlert(participant: participant, newPermission: .reader)
                }
            ),
            SpaceShareParticipantViewModel.ContextAction(
                title: Loc.SpaceShare.Permissions.writer,
                isSelected: participant.permission == .writer,
                destructive: false,
                action: { [weak self] in
                    self?.showPermissionAlert(participant: participant, newPermission: .writer)
                }
            ),
            SpaceShareParticipantViewModel.ContextAction(
                title: Loc.SpaceShare.RemoveMember.title,
                isSelected: false,
                destructive: true,
                action: { [weak self] in
                    self?.showRemoveAlert(participant: participant)
                }
            )
        ]
    }
    
    private func showRequestAlert(participant: Participant) {
        guard let spaceView = activeWorkspaceStorage.spaceView() else { return }
        
        requestAlertModel = SpaceRequestViewModel(
            icon: participant.icon?.icon,
            title: Loc.SpaceShare.ViewRequest.title(participant.name, spaceView.name),
            allowToAddMembers: allowToAddMembers,
            onViewAccess: { [weak self] in
                try await self?.workspaceService.requestApprove(spaceId: spaceView.targetSpaceId, identity: participant.identity, permissions: .reader)
            },
            onEditAccess: { [weak self] in
                try await self?.workspaceService.requestApprove(spaceId: spaceView.targetSpaceId, identity: participant.identity, permissions: .writer)
            },
            onReject: { [weak self] in
                try await self?.workspaceService.requestDecline(spaceId: spaceView.targetSpaceId, identity: participant.identity)
            }
        )
    }
    
    private func showPermissionAlert(participant: Participant, newPermission: ParticipantPermissions) {
        guard participant.permission != newPermission else { return }
        changeAccessAlertModel = SpaceChangeAccessViewModel(
            participantName: participant.name,
            permissions: newPermission.title,
            onConfirm: { [weak self] in
                try await self?.workspaceService.participantPermissionsChange(
                    spaceId: participant.spaceId,
                    identity: participant.identity,
                    permissions: newPermission
                )
            }
        )
    }
    
    private func showRemoveAlert(participant: Participant) {
        removeParticipantAlertModel = SpaceParticipantRemoveViewModel(
            participantName: participant.name,
            onConfirm: { [weak self] in
                try await self?.workspaceService.participantRemove(spaceId: participant.spaceId, identity: participant.identity)
            }
        )
    }
}

private extension Participant {
    var sortingWeight: Int {
        if permission == .owner {
            return 4
        }
        
        if status == .joining {
            return 3
        }
        
        if status == .declined {
            return 1
        }
        
        return 2
    }
}
