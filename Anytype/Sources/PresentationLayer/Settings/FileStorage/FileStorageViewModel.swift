import Foundation
import Services
import UIKit
import Combine
import AnytypeCore

@MainActor
final class FileStorageViewModel: ObservableObject {
    
    private let fileLimitsStorage: FileLimitsStorageProtocol
    private weak var output: FileStorageModuleOutput?
    private var subscriptions = [AnyCancellable]()
    
    private let byteCountFormatter = ByteCountFormatter.fileFormatter
    
    private var nodeUsage: NodeUsageInfo?
    private let subSpaceId = "FileStorageSpace-\(UUID().uuidString)"
    
    let phoneName: String = UIDevice.current.name
    @Published var locaUsed: String = ""
    @Published var contentLoaded: Bool = false
    
    init(
        fileLimitsStorage: FileLimitsStorageProtocol,
        output: FileStorageModuleOutput?
    ) {
        self.fileLimitsStorage = fileLimitsStorage
        self.output = output
        setupPlaceholderState()
        Task {
            await setupSubscription()
        }
    }
    
    func onTapOffloadFiles() {
        output?.onClearCacheSelected()
    }
    
    func onAppear() {
        AnytypeAnalytics.instance().logScreenSettingsStorageIndex()
    }

    // MARK: - Private
    
    private func setupSubscription() async {
        fileLimitsStorage.nodeUsage
            .receiveOnMain()
            .sink { [weak self] nodeUsage in
                // Some times middleware responds with big delay.
                // If middle upload a lot of files, read operation blocked.
                // May be fixed in feature.
                // Slack discussion https://anytypeio.slack.com/archives/C04QVG8V15K/p1684399017487419?thread_ts=1684244283.014759&cid=C04QVG8V15K
                self?.contentLoaded = true
                self?.nodeUsage = nodeUsage
                self?.updateView(nodeUsage: nodeUsage)
            }
            .store(in: &subscriptions)
    }
    
    private func setupPlaceholderState() {
        updateView(nodeUsage: .placeholder)
    }
    
    private func updateView(nodeUsage: NodeUsageInfo) {
        let localBytesUsage = nodeUsage.node.localBytesUsage
        let local = byteCountFormatter.string(fromByteCount: localBytesUsage)
        locaUsed = Loc.FileStorage.Local.used(local)
    }
}
