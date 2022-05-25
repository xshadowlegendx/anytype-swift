// DO NOT EDIT
//
// Generated automatically by the AnytypeSwiftCodegen.
//
// For more info see:
// https://github.com/anytypeio/anytype-swift-codegen

import Combine
import Foundation
import SwiftProtobuf

extension Anytype_Rpc.Account.Config {
  public init(enableDataview: Bool, enableDebug: Bool, enableReleaseChannelSwitch: Bool, enableSpaces: Bool, extra: SwiftProtobuf.Google_Protobuf_Struct) {
    self.enableDataview = enableDataview
    self.enableDebug = enableDebug
    self.enableReleaseChannelSwitch = enableReleaseChannelSwitch
    self.enableSpaces = enableSpaces
    self.extra = extra
  }
}

extension Anytype_Rpc.Account.Create.Request {
  public init(name: String, avatar: Anytype_Rpc.Account.Create.Request.OneOf_Avatar?, alphaInviteCode: String) {
    self.name = name
    self.avatar = avatar
    self.alphaInviteCode = alphaInviteCode
  }
}

extension Anytype_Rpc.Account.Create.Response {
  public init(error: Anytype_Rpc.Account.Create.Response.Error, account: Anytype_Model_Account, config: Anytype_Rpc.Account.Config) {
    self.error = error
    self.account = account
    self.config = config
  }
}

extension Anytype_Rpc.Account.Create.Response.Error {
  public init(code: Anytype_Rpc.Account.Create.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Account.Delete.Request {
  public init(revert: Bool) {
    self.revert = revert
  }
}

extension Anytype_Rpc.Account.Delete.Response {
  public init(error: Anytype_Rpc.Account.Delete.Response.Error, status: Anytype_Model_Account.Status) {
    self.error = error
    self.status = status
  }
}

extension Anytype_Rpc.Account.Delete.Response.Error {
  public init(code: Anytype_Rpc.Account.Delete.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Account.Recover.Response {
  public init(error: Anytype_Rpc.Account.Recover.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Account.Recover.Response.Error {
  public init(code: Anytype_Rpc.Account.Recover.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Account.Select.Request {
  public init(id: String, rootPath: String) {
    self.id = id
    self.rootPath = rootPath
  }
}

extension Anytype_Rpc.Account.Select.Response {
  public init(error: Anytype_Rpc.Account.Select.Response.Error, account: Anytype_Model_Account, config: Anytype_Rpc.Account.Config) {
    self.error = error
    self.account = account
    self.config = config
  }
}

extension Anytype_Rpc.Account.Select.Response.Error {
  public init(code: Anytype_Rpc.Account.Select.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Account.Stop.Request {
  public init(removeData: Bool) {
    self.removeData = removeData
  }
}

extension Anytype_Rpc.Account.Stop.Response {
  public init(error: Anytype_Rpc.Account.Stop.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Account.Stop.Response.Error {
  public init(code: Anytype_Rpc.Account.Stop.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ApplyTemplate.Request {
  public init(contextID: String, templateID: String) {
    self.contextID = contextID
    self.templateID = templateID
  }
}

extension Anytype_Rpc.ApplyTemplate.Response {
  public init(error: Anytype_Rpc.ApplyTemplate.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.ApplyTemplate.Response.Error {
  public init(code: Anytype_Rpc.ApplyTemplate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Bookmark.CreateAndFetch.Request {
  public init(contextID: String, targetID: String, position: Anytype_Model_Block.Position, url: String) {
    self.contextID = contextID
    self.targetID = targetID
    self.position = position
    self.url = url
  }
}

extension Anytype_Rpc.Block.Bookmark.CreateAndFetch.Response {
  public init(error: Anytype_Rpc.Block.Bookmark.CreateAndFetch.Response.Error, blockID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.blockID = blockID
    self.event = event
  }
}

extension Anytype_Rpc.Block.Bookmark.CreateAndFetch.Response.Error {
  public init(code: Anytype_Rpc.Block.Bookmark.CreateAndFetch.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Bookmark.Fetch.Request {
  public init(contextID: String, blockID: String, url: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.url = url
  }
}

extension Anytype_Rpc.Block.Bookmark.Fetch.Response {
  public init(error: Anytype_Rpc.Block.Bookmark.Fetch.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Bookmark.Fetch.Response.Error {
  public init(code: Anytype_Rpc.Block.Bookmark.Fetch.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Close.Request {
  public init(contextID: String, blockID: String) {
    self.contextID = contextID
    self.blockID = blockID
  }
}

extension Anytype_Rpc.Block.Close.Response {
  public init(error: Anytype_Rpc.Block.Close.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Block.Close.Response.Error {
  public init(code: Anytype_Rpc.Block.Close.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Copy.Request {
  public init(contextID: String, blocks: [Anytype_Model_Block], selectedTextRange: Anytype_Model_Range) {
    self.contextID = contextID
    self.blocks = blocks
    self.selectedTextRange = selectedTextRange
  }
}

extension Anytype_Rpc.Block.Copy.Response {
  public init(error: Anytype_Rpc.Block.Copy.Response.Error, textSlot: String, htmlSlot: String, anySlot: [Anytype_Model_Block]) {
    self.error = error
    self.textSlot = textSlot
    self.htmlSlot = htmlSlot
    self.anySlot = anySlot
  }
}

extension Anytype_Rpc.Block.Copy.Response.Error {
  public init(code: Anytype_Rpc.Block.Copy.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Create.Request {
  public init(contextID: String, targetID: String, block: Anytype_Model_Block, position: Anytype_Model_Block.Position) {
    self.contextID = contextID
    self.targetID = targetID
    self.block = block
    self.position = position
  }
}

extension Anytype_Rpc.Block.Create.Response {
  public init(error: Anytype_Rpc.Block.Create.Response.Error, blockID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.blockID = blockID
    self.event = event
  }
}

extension Anytype_Rpc.Block.Create.Response.Error {
  public init(code: Anytype_Rpc.Block.Create.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.CreatePage.Request {
  public init(
    contextID: String, details: SwiftProtobuf.Google_Protobuf_Struct, templateID: String, targetID: String, position: Anytype_Model_Block.Position, fields: SwiftProtobuf.Google_Protobuf_Struct
  ) {
    self.contextID = contextID
    self.details = details
    self.templateID = templateID
    self.targetID = targetID
    self.position = position
    self.fields = fields
  }
}

extension Anytype_Rpc.Block.CreatePage.Response {
  public init(error: Anytype_Rpc.Block.CreatePage.Response.Error, blockID: String, targetID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.blockID = blockID
    self.targetID = targetID
    self.event = event
  }
}

extension Anytype_Rpc.Block.CreatePage.Response.Error {
  public init(code: Anytype_Rpc.Block.CreatePage.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.CreateSet.Request {
  public init(contextID: String, targetID: String, source: [String], details: SwiftProtobuf.Google_Protobuf_Struct, position: Anytype_Model_Block.Position) {
    self.contextID = contextID
    self.targetID = targetID
    self.source = source
    self.details = details
    self.position = position
  }
}

extension Anytype_Rpc.Block.CreateSet.Response {
  public init(error: Anytype_Rpc.Block.CreateSet.Response.Error, blockID: String, targetID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.blockID = blockID
    self.targetID = targetID
    self.event = event
  }
}

extension Anytype_Rpc.Block.CreateSet.Response.Error {
  public init(code: Anytype_Rpc.Block.CreateSet.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Cut.Request {
  public init(contextID: String, blocks: [Anytype_Model_Block], selectedTextRange: Anytype_Model_Range) {
    self.contextID = contextID
    self.blocks = blocks
    self.selectedTextRange = selectedTextRange
  }
}

extension Anytype_Rpc.Block.Cut.Response {
  public init(error: Anytype_Rpc.Block.Cut.Response.Error, textSlot: String, htmlSlot: String, anySlot: [Anytype_Model_Block], event: Anytype_ResponseEvent) {
    self.error = error
    self.textSlot = textSlot
    self.htmlSlot = htmlSlot
    self.anySlot = anySlot
    self.event = event
  }
}

extension Anytype_Rpc.Block.Cut.Response.Error {
  public init(code: Anytype_Rpc.Block.Cut.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RecordCreate.Request {
  public init(contextID: String, blockID: String, record: SwiftProtobuf.Google_Protobuf_Struct, templateID: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.record = record
    self.templateID = templateID
  }
}

extension Anytype_Rpc.Block.Dataview.RecordCreate.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RecordCreate.Response.Error, record: SwiftProtobuf.Google_Protobuf_Struct) {
    self.error = error
    self.record = record
  }
}

extension Anytype_Rpc.Block.Dataview.RecordCreate.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RecordCreate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RecordDelete.Request {
  public init(contextID: String, blockID: String, recordID: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.recordID = recordID
  }
}

extension Anytype_Rpc.Block.Dataview.RecordDelete.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RecordDelete.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.RecordDelete.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RecordDelete.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RecordRelationOptionAdd.Request {
  public init(contextID: String, blockID: String, relationKey: String, option: Anytype_Model_Relation.Option, recordID: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.relationKey = relationKey
    self.option = option
    self.recordID = recordID
  }
}

extension Anytype_Rpc.Block.Dataview.RecordRelationOptionAdd.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RecordRelationOptionAdd.Response.Error, event: Anytype_ResponseEvent, option: Anytype_Model_Relation.Option) {
    self.error = error
    self.event = event
    self.option = option
  }
}

extension Anytype_Rpc.Block.Dataview.RecordRelationOptionAdd.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RecordRelationOptionAdd.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RecordRelationOptionDelete.Request {
  public init(contextID: String, blockID: String, relationKey: String, optionID: String, recordID: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.relationKey = relationKey
    self.optionID = optionID
    self.recordID = recordID
  }
}

extension Anytype_Rpc.Block.Dataview.RecordRelationOptionDelete.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RecordRelationOptionDelete.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.RecordRelationOptionDelete.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RecordRelationOptionDelete.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RecordRelationOptionUpdate.Request {
  public init(contextID: String, blockID: String, relationKey: String, option: Anytype_Model_Relation.Option, recordID: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.relationKey = relationKey
    self.option = option
    self.recordID = recordID
  }
}

extension Anytype_Rpc.Block.Dataview.RecordRelationOptionUpdate.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RecordRelationOptionUpdate.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.RecordRelationOptionUpdate.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RecordRelationOptionUpdate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RecordUpdate.Request {
  public init(contextID: String, blockID: String, recordID: String, record: SwiftProtobuf.Google_Protobuf_Struct) {
    self.contextID = contextID
    self.blockID = blockID
    self.recordID = recordID
    self.record = record
  }
}

extension Anytype_Rpc.Block.Dataview.RecordUpdate.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RecordUpdate.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Block.Dataview.RecordUpdate.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RecordUpdate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RelationAdd.Request {
  public init(contextID: String, blockID: String, relation: Anytype_Model_Relation) {
    self.contextID = contextID
    self.blockID = blockID
    self.relation = relation
  }
}

extension Anytype_Rpc.Block.Dataview.RelationAdd.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RelationAdd.Response.Error, event: Anytype_ResponseEvent, relationKey: String, relation: Anytype_Model_Relation) {
    self.error = error
    self.event = event
    self.relationKey = relationKey
    self.relation = relation
  }
}

extension Anytype_Rpc.Block.Dataview.RelationAdd.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RelationAdd.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RelationDelete.Request {
  public init(contextID: String, blockID: String, relationKey: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.relationKey = relationKey
  }
}

extension Anytype_Rpc.Block.Dataview.RelationDelete.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RelationDelete.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.RelationDelete.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RelationDelete.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RelationListAvailable.Request {
  public init(contextID: String, blockID: String) {
    self.contextID = contextID
    self.blockID = blockID
  }
}

extension Anytype_Rpc.Block.Dataview.RelationListAvailable.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RelationListAvailable.Response.Error, relations: [Anytype_Model_Relation]) {
    self.error = error
    self.relations = relations
  }
}

extension Anytype_Rpc.Block.Dataview.RelationListAvailable.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RelationListAvailable.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.RelationUpdate.Request {
  public init(contextID: String, blockID: String, relationKey: String, relation: Anytype_Model_Relation) {
    self.contextID = contextID
    self.blockID = blockID
    self.relationKey = relationKey
    self.relation = relation
  }
}

extension Anytype_Rpc.Block.Dataview.RelationUpdate.Response {
  public init(error: Anytype_Rpc.Block.Dataview.RelationUpdate.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.RelationUpdate.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.RelationUpdate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.SetSource.Request {
  public init(contextID: String, blockID: String, source: [String]) {
    self.contextID = contextID
    self.blockID = blockID
    self.source = source
  }
}

extension Anytype_Rpc.Block.Dataview.SetSource.Response {
  public init(error: Anytype_Rpc.Block.Dataview.SetSource.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.SetSource.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.SetSource.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.ViewCreate.Request {
  public init(contextID: String, blockID: String, view: Anytype_Model_Block.Content.Dataview.View) {
    self.contextID = contextID
    self.blockID = blockID
    self.view = view
  }
}

extension Anytype_Rpc.Block.Dataview.ViewCreate.Response {
  public init(error: Anytype_Rpc.Block.Dataview.ViewCreate.Response.Error, event: Anytype_ResponseEvent, viewID: String) {
    self.error = error
    self.event = event
    self.viewID = viewID
  }
}

extension Anytype_Rpc.Block.Dataview.ViewCreate.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.ViewCreate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.ViewDelete.Request {
  public init(contextID: String, blockID: String, viewID: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.viewID = viewID
  }
}

extension Anytype_Rpc.Block.Dataview.ViewDelete.Response {
  public init(error: Anytype_Rpc.Block.Dataview.ViewDelete.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.ViewDelete.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.ViewDelete.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.ViewSetActive.Request {
  public init(contextID: String, blockID: String, viewID: String, offset: UInt32, limit: UInt32) {
    self.contextID = contextID
    self.blockID = blockID
    self.viewID = viewID
    self.offset = offset
    self.limit = limit
  }
}

extension Anytype_Rpc.Block.Dataview.ViewSetActive.Response {
  public init(error: Anytype_Rpc.Block.Dataview.ViewSetActive.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.ViewSetActive.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.ViewSetActive.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.ViewSetPosition.Request {
  public init(contextID: String, blockID: String, viewID: String, position: UInt32) {
    self.contextID = contextID
    self.blockID = blockID
    self.viewID = viewID
    self.position = position
  }
}

extension Anytype_Rpc.Block.Dataview.ViewSetPosition.Response {
  public init(error: Anytype_Rpc.Block.Dataview.ViewSetPosition.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.ViewSetPosition.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.ViewSetPosition.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Dataview.ViewUpdate.Request {
  public init(contextID: String, blockID: String, viewID: String, view: Anytype_Model_Block.Content.Dataview.View) {
    self.contextID = contextID
    self.blockID = blockID
    self.viewID = viewID
    self.view = view
  }
}

extension Anytype_Rpc.Block.Dataview.ViewUpdate.Response {
  public init(error: Anytype_Rpc.Block.Dataview.ViewUpdate.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Dataview.ViewUpdate.Response.Error {
  public init(code: Anytype_Rpc.Block.Dataview.ViewUpdate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Download.Request {
  public init(contextID: String, blockID: String) {
    self.contextID = contextID
    self.blockID = blockID
  }
}

extension Anytype_Rpc.Block.Download.Response {
  public init(error: Anytype_Rpc.Block.Download.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Download.Response.Error {
  public init(code: Anytype_Rpc.Block.Download.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Export.Request {
  public init(contextID: String, blocks: [Anytype_Model_Block]) {
    self.contextID = contextID
    self.blocks = blocks
  }
}

extension Anytype_Rpc.Block.Export.Response {
  public init(error: Anytype_Rpc.Block.Export.Response.Error, path: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.path = path
    self.event = event
  }
}

extension Anytype_Rpc.Block.Export.Response.Error {
  public init(code: Anytype_Rpc.Block.Export.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.File.CreateAndUpload.Request {
  public init(contextID: String, targetID: String, position: Anytype_Model_Block.Position, url: String, localPath: String, fileType: Anytype_Model_Block.Content.File.TypeEnum) {
    self.contextID = contextID
    self.targetID = targetID
    self.position = position
    self.url = url
    self.localPath = localPath
    self.fileType = fileType
  }
}

extension Anytype_Rpc.Block.File.CreateAndUpload.Response {
  public init(error: Anytype_Rpc.Block.File.CreateAndUpload.Response.Error, blockID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.blockID = blockID
    self.event = event
  }
}

extension Anytype_Rpc.Block.File.CreateAndUpload.Response.Error {
  public init(code: Anytype_Rpc.Block.File.CreateAndUpload.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Get.Marks.Request {
  public init(contextID: String, blockID: String, range: Anytype_Model_Range) {
    self.contextID = contextID
    self.blockID = blockID
    self.range = range
  }
}

extension Anytype_Rpc.Block.Get.Marks.Response {
  public init(error: Anytype_Rpc.Block.Get.Marks.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Get.Marks.Response.Error {
  public init(code: Anytype_Rpc.Block.Get.Marks.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.GetPublicWebURL.Request {
  public init(blockID: String) {
    self.blockID = blockID
  }
}

extension Anytype_Rpc.Block.GetPublicWebURL.Response {
  public init(error: Anytype_Rpc.Block.GetPublicWebURL.Response.Error, url: String) {
    self.error = error
    self.url = url
  }
}

extension Anytype_Rpc.Block.GetPublicWebURL.Response.Error {
  public init(code: Anytype_Rpc.Block.GetPublicWebURL.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.ImportMarkdown.Request {
  public init(contextID: String, importPath: String) {
    self.contextID = contextID
    self.importPath = importPath
  }
}

extension Anytype_Rpc.Block.ImportMarkdown.Response {
  public init(error: Anytype_Rpc.Block.ImportMarkdown.Response.Error, rootLinkIds: [String], event: Anytype_ResponseEvent) {
    self.error = error
    self.rootLinkIds = rootLinkIds
    self.event = event
  }
}

extension Anytype_Rpc.Block.ImportMarkdown.Response.Error {
  public init(code: Anytype_Rpc.Block.ImportMarkdown.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Merge.Request {
  public init(contextID: String, firstBlockID: String, secondBlockID: String) {
    self.contextID = contextID
    self.firstBlockID = firstBlockID
    self.secondBlockID = secondBlockID
  }
}

extension Anytype_Rpc.Block.Merge.Response {
  public init(error: Anytype_Rpc.Block.Merge.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Merge.Response.Error {
  public init(code: Anytype_Rpc.Block.Merge.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.ObjectType.Set.Request {
  public init(contextID: String, objectTypeURL: String) {
    self.contextID = contextID
    self.objectTypeURL = objectTypeURL
  }
}

extension Anytype_Rpc.Block.ObjectType.Set.Response {
  public init(error: Anytype_Rpc.Block.ObjectType.Set.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.ObjectType.Set.Response.Error {
  public init(code: Anytype_Rpc.Block.ObjectType.Set.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Open.Request {
  public init(contextID: String, blockID: String, traceID: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.traceID = traceID
  }
}

extension Anytype_Rpc.Block.Open.Response {
  public init(error: Anytype_Rpc.Block.Open.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Open.Response.Error {
  public init(code: Anytype_Rpc.Block.Open.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.OpenBreadcrumbs.Request {
  public init(contextID: String, traceID: String) {
    self.contextID = contextID
    self.traceID = traceID
  }
}

extension Anytype_Rpc.Block.OpenBreadcrumbs.Response {
  public init(error: Anytype_Rpc.Block.OpenBreadcrumbs.Response.Error, blockID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.blockID = blockID
    self.event = event
  }
}

extension Anytype_Rpc.Block.OpenBreadcrumbs.Response.Error {
  public init(code: Anytype_Rpc.Block.OpenBreadcrumbs.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Paste.Request {
  public init(
    contextID: String, focusedBlockID: String, selectedTextRange: Anytype_Model_Range, selectedBlockIds: [String], isPartOfBlock: Bool, textSlot: String, htmlSlot: String,
    anySlot: [Anytype_Model_Block], fileSlot: [Anytype_Rpc.Block.Paste.Request.File]
  ) {
    self.contextID = contextID
    self.focusedBlockID = focusedBlockID
    self.selectedTextRange = selectedTextRange
    self.selectedBlockIds = selectedBlockIds
    self.isPartOfBlock = isPartOfBlock
    self.textSlot = textSlot
    self.htmlSlot = htmlSlot
    self.anySlot = anySlot
    self.fileSlot = fileSlot
  }
}

extension Anytype_Rpc.Block.Paste.Request.File {
  public init(name: String, data: Data, localPath: String) {
    self.name = name
    self.data = data
    self.localPath = localPath
  }
}

extension Anytype_Rpc.Block.Paste.Response {
  public init(error: Anytype_Rpc.Block.Paste.Response.Error, blockIds: [String], caretPosition: Int32, isSameBlockCaret: Bool, event: Anytype_ResponseEvent) {
    self.error = error
    self.blockIds = blockIds
    self.caretPosition = caretPosition
    self.isSameBlockCaret = isSameBlockCaret
    self.event = event
  }
}

extension Anytype_Rpc.Block.Paste.Response.Error {
  public init(code: Anytype_Rpc.Block.Paste.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Redo.Request {
  public init(contextID: String) {
    self.contextID = contextID
  }
}

extension Anytype_Rpc.Block.Redo.Response {
  public init(error: Anytype_Rpc.Block.Redo.Response.Error, event: Anytype_ResponseEvent, counters: Anytype_Rpc.Block.UndoRedoCounter) {
    self.error = error
    self.event = event
    self.counters = counters
  }
}

extension Anytype_Rpc.Block.Redo.Response.Error {
  public init(code: Anytype_Rpc.Block.Redo.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Relation.Add.Request {
  public init(contextID: String, blockID: String, relation: Anytype_Model_Relation) {
    self.contextID = contextID
    self.blockID = blockID
    self.relation = relation
  }
}

extension Anytype_Rpc.Block.Relation.Add.Response {
  public init(error: Anytype_Rpc.Block.Relation.Add.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Relation.Add.Response.Error {
  public init(code: Anytype_Rpc.Block.Relation.Add.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Relation.SetKey.Request {
  public init(contextID: String, blockID: String, key: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.key = key
  }
}

extension Anytype_Rpc.Block.Relation.SetKey.Response {
  public init(error: Anytype_Rpc.Block.Relation.SetKey.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Relation.SetKey.Response.Error {
  public init(code: Anytype_Rpc.Block.Relation.SetKey.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Replace.Request {
  public init(contextID: String, blockID: String, block: Anytype_Model_Block) {
    self.contextID = contextID
    self.blockID = blockID
    self.block = block
  }
}

extension Anytype_Rpc.Block.Replace.Response {
  public init(error: Anytype_Rpc.Block.Replace.Response.Error, blockID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.blockID = blockID
    self.event = event
  }
}

extension Anytype_Rpc.Block.Replace.Response.Error {
  public init(code: Anytype_Rpc.Block.Replace.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Details.Detail {
  public init(key: String, value: SwiftProtobuf.Google_Protobuf_Value) {
    self.key = key
    self.value = value
  }
}

extension Anytype_Rpc.Block.Set.Details.Request {
  public init(contextID: String, details: [Anytype_Rpc.Block.Set.Details.Detail]) {
    self.contextID = contextID
    self.details = details
  }
}

extension Anytype_Rpc.Block.Set.Details.Response {
  public init(error: Anytype_Rpc.Block.Set.Details.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Details.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Details.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Fields.Request {
  public init(contextID: String, blockID: String, fields: SwiftProtobuf.Google_Protobuf_Struct) {
    self.contextID = contextID
    self.blockID = blockID
    self.fields = fields
  }
}

extension Anytype_Rpc.Block.Set.Fields.Response {
  public init(error: Anytype_Rpc.Block.Set.Fields.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Fields.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Fields.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.File.Name.Request {
  public init(contextID: String, blockID: String, name: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.name = name
  }
}

extension Anytype_Rpc.Block.Set.File.Name.Response {
  public init(error: Anytype_Rpc.Block.Set.File.Name.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.File.Name.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.File.Name.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Image.Name.Request {
  public init(contextID: String, blockID: String, name: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.name = name
  }
}

extension Anytype_Rpc.Block.Set.Image.Name.Response {
  public init(error: Anytype_Rpc.Block.Set.Image.Name.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Block.Set.Image.Name.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Image.Name.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Image.Width.Request {
  public init(contextID: String, blockID: String, width: Int32) {
    self.contextID = contextID
    self.blockID = blockID
    self.width = width
  }
}

extension Anytype_Rpc.Block.Set.Image.Width.Response {
  public init(error: Anytype_Rpc.Block.Set.Image.Width.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Block.Set.Image.Width.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Image.Width.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Latex.Text.Request {
  public init(contextID: String, blockID: String, text: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.text = text
  }
}

extension Anytype_Rpc.Block.Set.Latex.Text.Response {
  public init(error: Anytype_Rpc.Block.Set.Latex.Text.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Latex.Text.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Latex.Text.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Link.TargetBlockId.Request {
  public init(contextID: String, blockID: String, targetBlockID: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.targetBlockID = targetBlockID
  }
}

extension Anytype_Rpc.Block.Set.Link.TargetBlockId.Response {
  public init(error: Anytype_Rpc.Block.Set.Link.TargetBlockId.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Link.TargetBlockId.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Link.TargetBlockId.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Page.IsArchived.Request {
  public init(contextID: String, blockID: String, isArchived: Bool) {
    self.contextID = contextID
    self.blockID = blockID
    self.isArchived = isArchived
  }
}

extension Anytype_Rpc.Block.Set.Page.IsArchived.Response {
  public init(error: Anytype_Rpc.Block.Set.Page.IsArchived.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Block.Set.Page.IsArchived.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Page.IsArchived.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Restrictions.Request {
  public init(contextID: String, blockID: String, restrictions: Anytype_Model_Block.Restrictions) {
    self.contextID = contextID
    self.blockID = blockID
    self.restrictions = restrictions
  }
}

extension Anytype_Rpc.Block.Set.Restrictions.Response {
  public init(error: Anytype_Rpc.Block.Set.Restrictions.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Restrictions.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Restrictions.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Text.Checked.Request {
  public init(contextID: String, blockID: String, checked: Bool) {
    self.contextID = contextID
    self.blockID = blockID
    self.checked = checked
  }
}

extension Anytype_Rpc.Block.Set.Text.Checked.Response {
  public init(error: Anytype_Rpc.Block.Set.Text.Checked.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Text.Checked.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Text.Checked.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Text.Color.Request {
  public init(contextID: String, blockID: String, color: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.color = color
  }
}

extension Anytype_Rpc.Block.Set.Text.Color.Response {
  public init(error: Anytype_Rpc.Block.Set.Text.Color.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Text.Color.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Text.Color.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Text.Icon.Request {
  public init(contextID: String, blockID: String, iconImage: String, iconEmoji: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.iconImage = iconImage
    self.iconEmoji = iconEmoji
  }
}

extension Anytype_Rpc.Block.Set.Text.Icon.Response {
  public init(error: Anytype_Rpc.Block.Set.Text.Icon.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Text.Icon.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Text.Icon.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Text.Style.Request {
  public init(contextID: String, blockID: String, style: Anytype_Model_Block.Content.Text.Style) {
    self.contextID = contextID
    self.blockID = blockID
    self.style = style
  }
}

extension Anytype_Rpc.Block.Set.Text.Style.Response {
  public init(error: Anytype_Rpc.Block.Set.Text.Style.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Text.Style.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Text.Style.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Text.Text.Request {
  public init(contextID: String, blockID: String, text: String, marks: Anytype_Model_Block.Content.Text.Marks) {
    self.contextID = contextID
    self.blockID = blockID
    self.text = text
    self.marks = marks
  }
}

extension Anytype_Rpc.Block.Set.Text.Text.Response {
  public init(error: Anytype_Rpc.Block.Set.Text.Text.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Set.Text.Text.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Text.Text.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Video.Name.Request {
  public init(contextID: String, blockID: String, name: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.name = name
  }
}

extension Anytype_Rpc.Block.Set.Video.Name.Response {
  public init(error: Anytype_Rpc.Block.Set.Video.Name.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Block.Set.Video.Name.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Video.Name.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Set.Video.Width.Request {
  public init(contextID: String, blockID: String, width: Int32) {
    self.contextID = contextID
    self.blockID = blockID
    self.width = width
  }
}

extension Anytype_Rpc.Block.Set.Video.Width.Response {
  public init(error: Anytype_Rpc.Block.Set.Video.Width.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Block.Set.Video.Width.Response.Error {
  public init(code: Anytype_Rpc.Block.Set.Video.Width.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.SetBreadcrumbs.Request {
  public init(breadcrumbsID: String, ids: [String]) {
    self.breadcrumbsID = breadcrumbsID
    self.ids = ids
  }
}

extension Anytype_Rpc.Block.SetBreadcrumbs.Response {
  public init(error: Anytype_Rpc.Block.SetBreadcrumbs.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.SetBreadcrumbs.Response.Error {
  public init(code: Anytype_Rpc.Block.SetBreadcrumbs.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Show.Request {
  public init(contextID: String, blockID: String, traceID: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.traceID = traceID
  }
}

extension Anytype_Rpc.Block.Show.Response {
  public init(error: Anytype_Rpc.Block.Show.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Show.Response.Error {
  public init(code: Anytype_Rpc.Block.Show.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Split.Request {
  public init(contextID: String, blockID: String, range: Anytype_Model_Range, style: Anytype_Model_Block.Content.Text.Style, mode: Anytype_Rpc.Block.Split.Request.Mode) {
    self.contextID = contextID
    self.blockID = blockID
    self.range = range
    self.style = style
    self.mode = mode
  }
}

extension Anytype_Rpc.Block.Split.Response {
  public init(error: Anytype_Rpc.Block.Split.Response.Error, blockID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.blockID = blockID
    self.event = event
  }
}

extension Anytype_Rpc.Block.Split.Response.Error {
  public init(code: Anytype_Rpc.Block.Split.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Undo.Request {
  public init(contextID: String) {
    self.contextID = contextID
  }
}

extension Anytype_Rpc.Block.Undo.Response {
  public init(error: Anytype_Rpc.Block.Undo.Response.Error, event: Anytype_ResponseEvent, counters: Anytype_Rpc.Block.UndoRedoCounter) {
    self.error = error
    self.event = event
    self.counters = counters
  }
}

extension Anytype_Rpc.Block.Undo.Response.Error {
  public init(code: Anytype_Rpc.Block.Undo.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.UndoRedoCounter {
  public init(undo: Int32, redo: Int32) {
    self.undo = undo
    self.redo = redo
  }
}

extension Anytype_Rpc.Block.Unlink.Request {
  public init(contextID: String, blockIds: [String]) {
    self.contextID = contextID
    self.blockIds = blockIds
  }
}

extension Anytype_Rpc.Block.Unlink.Response {
  public init(error: Anytype_Rpc.Block.Unlink.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Unlink.Response.Error {
  public init(code: Anytype_Rpc.Block.Unlink.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.UpdateContent.Request {
  public init(contextID: String, blockID: String, block: Anytype_Model_Block) {
    self.contextID = contextID
    self.blockID = blockID
    self.block = block
  }
}

extension Anytype_Rpc.Block.UpdateContent.Response {
  public init(error: Anytype_Rpc.Block.UpdateContent.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.UpdateContent.Response.Error {
  public init(code: Anytype_Rpc.Block.UpdateContent.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Block.Upload.Request {
  public init(contextID: String, blockID: String, filePath: String, url: String) {
    self.contextID = contextID
    self.blockID = blockID
    self.filePath = filePath
    self.url = url
  }
}

extension Anytype_Rpc.Block.Upload.Response {
  public init(error: Anytype_Rpc.Block.Upload.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Block.Upload.Response.Error {
  public init(code: Anytype_Rpc.Block.Upload.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.ConvertChildrenToPages.Request {
  public init(contextID: String, blockIds: [String], objectType: String) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.objectType = objectType
  }
}

extension Anytype_Rpc.BlockList.ConvertChildrenToPages.Response {
  public init(error: Anytype_Rpc.BlockList.ConvertChildrenToPages.Response.Error, linkIds: [String]) {
    self.error = error
    self.linkIds = linkIds
  }
}

extension Anytype_Rpc.BlockList.ConvertChildrenToPages.Response.Error {
  public init(code: Anytype_Rpc.BlockList.ConvertChildrenToPages.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Duplicate.Request {
  public init(contextID: String, targetID: String, blockIds: [String], position: Anytype_Model_Block.Position) {
    self.contextID = contextID
    self.targetID = targetID
    self.blockIds = blockIds
    self.position = position
  }
}

extension Anytype_Rpc.BlockList.Duplicate.Response {
  public init(error: Anytype_Rpc.BlockList.Duplicate.Response.Error, blockIds: [String], event: Anytype_ResponseEvent) {
    self.error = error
    self.blockIds = blockIds
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Duplicate.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Duplicate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Move.Request {
  public init(contextID: String, blockIds: [String], targetContextID: String, dropTargetID: String, position: Anytype_Model_Block.Position) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.targetContextID = targetContextID
    self.dropTargetID = dropTargetID
    self.position = position
  }
}

extension Anytype_Rpc.BlockList.Move.Response {
  public init(error: Anytype_Rpc.BlockList.Move.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Move.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Move.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.MoveToNewPage.Request {
  public init(contextID: String, blockIds: [String], details: SwiftProtobuf.Google_Protobuf_Struct, dropTargetID: String, position: Anytype_Model_Block.Position) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.details = details
    self.dropTargetID = dropTargetID
    self.position = position
  }
}

extension Anytype_Rpc.BlockList.MoveToNewPage.Response {
  public init(error: Anytype_Rpc.BlockList.MoveToNewPage.Response.Error, linkID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.linkID = linkID
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.MoveToNewPage.Response.Error {
  public init(code: Anytype_Rpc.BlockList.MoveToNewPage.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Set.Align.Request {
  public init(contextID: String, blockIds: [String], align: Anytype_Model_Block.Align) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.align = align
  }
}

extension Anytype_Rpc.BlockList.Set.Align.Response {
  public init(error: Anytype_Rpc.BlockList.Set.Align.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Set.Align.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Set.Align.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Set.BackgroundColor.Request {
  public init(contextID: String, blockIds: [String], color: String) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.color = color
  }
}

extension Anytype_Rpc.BlockList.Set.BackgroundColor.Response {
  public init(error: Anytype_Rpc.BlockList.Set.BackgroundColor.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Set.BackgroundColor.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Set.BackgroundColor.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Set.Div.Style.Request {
  public init(contextID: String, blockIds: [String], style: Anytype_Model_Block.Content.Div.Style) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.style = style
  }
}

extension Anytype_Rpc.BlockList.Set.Div.Style.Response {
  public init(error: Anytype_Rpc.BlockList.Set.Div.Style.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Set.Div.Style.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Set.Div.Style.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Set.Fields.Request {
  public init(contextID: String, blockFields: [Anytype_Rpc.BlockList.Set.Fields.Request.BlockField]) {
    self.contextID = contextID
    self.blockFields = blockFields
  }
}

extension Anytype_Rpc.BlockList.Set.Fields.Request.BlockField {
  public init(blockID: String, fields: SwiftProtobuf.Google_Protobuf_Struct) {
    self.blockID = blockID
    self.fields = fields
  }
}

extension Anytype_Rpc.BlockList.Set.Fields.Response {
  public init(error: Anytype_Rpc.BlockList.Set.Fields.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Set.Fields.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Set.Fields.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Set.File.Style.Request {
  public init(contextID: String, blockIds: [String], style: Anytype_Model_Block.Content.File.Style) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.style = style
  }
}

extension Anytype_Rpc.BlockList.Set.File.Style.Response {
  public init(error: Anytype_Rpc.BlockList.Set.File.Style.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Set.File.Style.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Set.File.Style.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Set.Text.Color.Request {
  public init(contextID: String, blockIds: [String], color: String) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.color = color
  }
}

extension Anytype_Rpc.BlockList.Set.Text.Color.Response {
  public init(error: Anytype_Rpc.BlockList.Set.Text.Color.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Set.Text.Color.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Set.Text.Color.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Set.Text.Mark.Request {
  public init(contextID: String, blockIds: [String], mark: Anytype_Model_Block.Content.Text.Mark) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.mark = mark
  }
}

extension Anytype_Rpc.BlockList.Set.Text.Mark.Response {
  public init(error: Anytype_Rpc.BlockList.Set.Text.Mark.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Set.Text.Mark.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Set.Text.Mark.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.Set.Text.Style.Request {
  public init(contextID: String, blockIds: [String], style: Anytype_Model_Block.Content.Text.Style) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.style = style
  }
}

extension Anytype_Rpc.BlockList.Set.Text.Style.Response {
  public init(error: Anytype_Rpc.BlockList.Set.Text.Style.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.Set.Text.Style.Response.Error {
  public init(code: Anytype_Rpc.BlockList.Set.Text.Style.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.BlockList.TurnInto.Request {
  public init(contextID: String, blockIds: [String], style: Anytype_Model_Block.Content.Text.Style) {
    self.contextID = contextID
    self.blockIds = blockIds
    self.style = style
  }
}

extension Anytype_Rpc.BlockList.TurnInto.Response {
  public init(error: Anytype_Rpc.BlockList.TurnInto.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.BlockList.TurnInto.Response.Error {
  public init(code: Anytype_Rpc.BlockList.TurnInto.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.CloneTemplate.Request {
  public init(contextID: String) {
    self.contextID = contextID
  }
}

extension Anytype_Rpc.CloneTemplate.Response {
  public init(error: Anytype_Rpc.CloneTemplate.Response.Error, id: String) {
    self.error = error
    self.id = id
  }
}

extension Anytype_Rpc.CloneTemplate.Response.Error {
  public init(code: Anytype_Rpc.CloneTemplate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Config.Get.Response {
  public init(
    error: Anytype_Rpc.Config.Get.Response.Error, homeBlockID: String, archiveBlockID: String, profileBlockID: String, marketplaceTypeID: String, marketplaceRelationID: String,
    marketplaceTemplateID: String, deviceID: String, gatewayURL: String
  ) {
    self.error = error
    self.homeBlockID = homeBlockID
    self.archiveBlockID = archiveBlockID
    self.profileBlockID = profileBlockID
    self.marketplaceTypeID = marketplaceTypeID
    self.marketplaceRelationID = marketplaceRelationID
    self.marketplaceTemplateID = marketplaceTemplateID
    self.deviceID = deviceID
    self.gatewayURL = gatewayURL
  }
}

extension Anytype_Rpc.Config.Get.Response.Error {
  public init(code: Anytype_Rpc.Config.Get.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Debug.Sync.Request {
  public init(recordsTraverseLimit: Int32, skipEmptyLogs: Bool, tryToDownloadRemoteRecords: Bool) {
    self.recordsTraverseLimit = recordsTraverseLimit
    self.skipEmptyLogs = skipEmptyLogs
    self.tryToDownloadRemoteRecords = tryToDownloadRemoteRecords
  }
}

extension Anytype_Rpc.Debug.Sync.Response {
  public init(
    error: Anytype_Rpc.Debug.Sync.Response.Error, threads: [Anytype_Rpc.Debug.threadInfo], deviceID: String, totalThreads: Int32, threadsWithoutReplInOwnLog: Int32,
    threadsWithoutHeadDownloaded: Int32, totalRecords: Int32, totalSize: Int32
  ) {
    self.error = error
    self.threads = threads
    self.deviceID = deviceID
    self.totalThreads = totalThreads
    self.threadsWithoutReplInOwnLog = threadsWithoutReplInOwnLog
    self.threadsWithoutHeadDownloaded = threadsWithoutHeadDownloaded
    self.totalRecords = totalRecords
    self.totalSize = totalSize
  }
}

extension Anytype_Rpc.Debug.Sync.Response.Error {
  public init(code: Anytype_Rpc.Debug.Sync.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Debug.Thread.Request {
  public init(threadID: String, skipEmptyLogs: Bool, tryToDownloadRemoteRecords: Bool) {
    self.threadID = threadID
    self.skipEmptyLogs = skipEmptyLogs
    self.tryToDownloadRemoteRecords = tryToDownloadRemoteRecords
  }
}

extension Anytype_Rpc.Debug.Thread.Response {
  public init(error: Anytype_Rpc.Debug.Thread.Response.Error, info: Anytype_Rpc.Debug.threadInfo) {
    self.error = error
    self.info = info
  }
}

extension Anytype_Rpc.Debug.Thread.Response.Error {
  public init(code: Anytype_Rpc.Debug.Thread.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Debug.Tree.Request {
  public init(blockID: String, path: String, unanonymized: Bool) {
    self.blockID = blockID
    self.path = path
    self.unanonymized = unanonymized
  }
}

extension Anytype_Rpc.Debug.Tree.Response {
  public init(error: Anytype_Rpc.Debug.Tree.Response.Error, filename: String) {
    self.error = error
    self.filename = filename
  }
}

extension Anytype_Rpc.Debug.Tree.Response.Error {
  public init(code: Anytype_Rpc.Debug.Tree.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Debug.logInfo {
  public init(
    id: String, head: String, headDownloaded: Bool, totalRecords: Int32, totalSize: Int32, firstRecordTs: Int32, firstRecordVer: Int32, lastRecordTs: Int32, lastRecordVer: Int32,
    lastPullSecAgo: Int32, upStatus: String, downStatus: String, error: String
  ) {
    self.id = id
    self.head = head
    self.headDownloaded = headDownloaded
    self.totalRecords = totalRecords
    self.totalSize = totalSize
    self.firstRecordTs = firstRecordTs
    self.firstRecordVer = firstRecordVer
    self.lastRecordTs = lastRecordTs
    self.lastRecordVer = lastRecordVer
    self.lastPullSecAgo = lastPullSecAgo
    self.upStatus = upStatus
    self.downStatus = downStatus
    self.error = error
  }
}

extension Anytype_Rpc.Debug.threadInfo {
  public init(
    id: String, logsWithDownloadedHead: Int32, logsWithWholeTreeDownloaded: Int32, logs: [Anytype_Rpc.Debug.logInfo], ownLogHasCafeReplicator: Bool, cafeLastPullSecAgo: Int32, cafeUpStatus: String,
    cafeDownStatus: String, totalRecords: Int32, totalSize: Int32, error: String
  ) {
    self.id = id
    self.logsWithDownloadedHead = logsWithDownloadedHead
    self.logsWithWholeTreeDownloaded = logsWithWholeTreeDownloaded
    self.logs = logs
    self.ownLogHasCafeReplicator = ownLogHasCafeReplicator
    self.cafeLastPullSecAgo = cafeLastPullSecAgo
    self.cafeUpStatus = cafeUpStatus
    self.cafeDownStatus = cafeDownStatus
    self.totalRecords = totalRecords
    self.totalSize = totalSize
    self.error = error
  }
}

extension Anytype_Rpc.DownloadFile.Request {
  public init(hash: String, path: String) {
    self.hash = hash
    self.path = path
  }
}

extension Anytype_Rpc.DownloadFile.Response {
  public init(error: Anytype_Rpc.DownloadFile.Response.Error, localPath: String) {
    self.error = error
    self.localPath = localPath
  }
}

extension Anytype_Rpc.DownloadFile.Response.Error {
  public init(code: Anytype_Rpc.DownloadFile.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Export.Request {
  public init(path: String, docIds: [String], format: Anytype_Rpc.Export.Format, zip: Bool, includeNested: Bool, includeFiles: Bool) {
    self.path = path
    self.docIds = docIds
    self.format = format
    self.zip = zip
    self.includeNested = includeNested
    self.includeFiles = includeFiles
  }
}

extension Anytype_Rpc.Export.Response {
  public init(error: Anytype_Rpc.Export.Response.Error, path: String, succeed: Int32, event: Anytype_ResponseEvent) {
    self.error = error
    self.path = path
    self.succeed = succeed
    self.event = event
  }
}

extension Anytype_Rpc.Export.Response.Error {
  public init(code: Anytype_Rpc.Export.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ExportLocalstore.Request {
  public init(path: String, docIds: [String]) {
    self.path = path
    self.docIds = docIds
  }
}

extension Anytype_Rpc.ExportLocalstore.Response {
  public init(error: Anytype_Rpc.ExportLocalstore.Response.Error, path: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.path = path
    self.event = event
  }
}

extension Anytype_Rpc.ExportLocalstore.Response.Error {
  public init(code: Anytype_Rpc.ExportLocalstore.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ExportTemplates.Request {
  public init(path: String) {
    self.path = path
  }
}

extension Anytype_Rpc.ExportTemplates.Response {
  public init(error: Anytype_Rpc.ExportTemplates.Response.Error, path: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.path = path
    self.event = event
  }
}

extension Anytype_Rpc.ExportTemplates.Response.Error {
  public init(code: Anytype_Rpc.ExportTemplates.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ExportWorkspace.Request {
  public init(path: String, workspaceID: String) {
    self.path = path
    self.workspaceID = workspaceID
  }
}

extension Anytype_Rpc.ExportWorkspace.Response {
  public init(error: Anytype_Rpc.ExportWorkspace.Response.Error, path: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.path = path
    self.event = event
  }
}

extension Anytype_Rpc.ExportWorkspace.Response.Error {
  public init(code: Anytype_Rpc.ExportWorkspace.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ExternalDrop.Content.Request {
  public init(contextID: String, focusedBlockID: String, content: Data) {
    self.contextID = contextID
    self.focusedBlockID = focusedBlockID
    self.content = content
  }
}

extension Anytype_Rpc.ExternalDrop.Content.Response {
  public init(error: Anytype_Rpc.ExternalDrop.Content.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.ExternalDrop.Content.Response.Error {
  public init(code: Anytype_Rpc.ExternalDrop.Content.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ExternalDrop.Files.Request {
  public init(contextID: String, dropTargetID: String, position: Anytype_Model_Block.Position, localFilePaths: [String]) {
    self.contextID = contextID
    self.dropTargetID = dropTargetID
    self.position = position
    self.localFilePaths = localFilePaths
  }
}

extension Anytype_Rpc.ExternalDrop.Files.Response {
  public init(error: Anytype_Rpc.ExternalDrop.Files.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.ExternalDrop.Files.Response.Error {
  public init(code: Anytype_Rpc.ExternalDrop.Files.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.File.Offload.Request {
  public init(id: String, includeNotPinned: Bool) {
    self.id = id
    self.includeNotPinned = includeNotPinned
  }
}

extension Anytype_Rpc.File.Offload.Response {
  public init(error: Anytype_Rpc.File.Offload.Response.Error, bytesOffloaded: UInt64) {
    self.error = error
    self.bytesOffloaded = bytesOffloaded
  }
}

extension Anytype_Rpc.File.Offload.Response.Error {
  public init(code: Anytype_Rpc.File.Offload.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.FileList.Offload.Request {
  public init(onlyIds: [String], includeNotPinned: Bool) {
    self.onlyIds = onlyIds
    self.includeNotPinned = includeNotPinned
  }
}

extension Anytype_Rpc.FileList.Offload.Response {
  public init(error: Anytype_Rpc.FileList.Offload.Response.Error, filesOffloaded: Int32, bytesOffloaded: UInt64) {
    self.error = error
    self.filesOffloaded = filesOffloaded
    self.bytesOffloaded = bytesOffloaded
  }
}

extension Anytype_Rpc.FileList.Offload.Response.Error {
  public init(code: Anytype_Rpc.FileList.Offload.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.GenericErrorResponse {
  public init(error: Anytype_Rpc.GenericErrorResponse.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.GenericErrorResponse.Error {
  public init(code: Anytype_Rpc.GenericErrorResponse.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.History.SetVersion.Request {
  public init(pageID: String, versionID: String) {
    self.pageID = pageID
    self.versionID = versionID
  }
}

extension Anytype_Rpc.History.SetVersion.Response {
  public init(error: Anytype_Rpc.History.SetVersion.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.History.SetVersion.Response.Error {
  public init(code: Anytype_Rpc.History.SetVersion.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.History.Show.Request {
  public init(pageID: String, versionID: String, traceID: String) {
    self.pageID = pageID
    self.versionID = versionID
    self.traceID = traceID
  }
}

extension Anytype_Rpc.History.Show.Response {
  public init(error: Anytype_Rpc.History.Show.Response.Error, objectShow: Anytype_Event.Object.Show, version: Anytype_Rpc.History.Versions.Version, traceID: String) {
    self.error = error
    self.objectShow = objectShow
    self.version = version
    self.traceID = traceID
  }
}

extension Anytype_Rpc.History.Show.Response.Error {
  public init(code: Anytype_Rpc.History.Show.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.History.Versions.Request {
  public init(pageID: String, lastVersionID: String, limit: Int32) {
    self.pageID = pageID
    self.lastVersionID = lastVersionID
    self.limit = limit
  }
}

extension Anytype_Rpc.History.Versions.Response {
  public init(error: Anytype_Rpc.History.Versions.Response.Error, versions: [Anytype_Rpc.History.Versions.Version]) {
    self.error = error
    self.versions = versions
  }
}

extension Anytype_Rpc.History.Versions.Response.Error {
  public init(code: Anytype_Rpc.History.Versions.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.History.Versions.Version {
  public init(id: String, previousIds: [String], authorID: String, authorName: String, time: Int64, groupID: Int64) {
    self.id = id
    self.previousIds = previousIds
    self.authorID = authorID
    self.authorName = authorName
    self.time = time
    self.groupID = groupID
  }
}

extension Anytype_Rpc.LinkPreview.Request {
  public init(url: String) {
    self.url = url
  }
}

extension Anytype_Rpc.LinkPreview.Response {
  public init(error: Anytype_Rpc.LinkPreview.Response.Error, linkPreview: Anytype_Model_LinkPreview) {
    self.error = error
    self.linkPreview = linkPreview
  }
}

extension Anytype_Rpc.LinkPreview.Response.Error {
  public init(code: Anytype_Rpc.LinkPreview.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Log.Send.Request {
  public init(message: String, level: Anytype_Rpc.Log.Send.Request.Level) {
    self.message = message
    self.level = level
  }
}

extension Anytype_Rpc.Log.Send.Response {
  public init(error: Anytype_Rpc.Log.Send.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Log.Send.Response.Error {
  public init(code: Anytype_Rpc.Log.Send.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.MakeTemplate.Request {
  public init(contextID: String) {
    self.contextID = contextID
  }
}

extension Anytype_Rpc.MakeTemplate.Response {
  public init(error: Anytype_Rpc.MakeTemplate.Response.Error, id: String) {
    self.error = error
    self.id = id
  }
}

extension Anytype_Rpc.MakeTemplate.Response.Error {
  public init(code: Anytype_Rpc.MakeTemplate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.MakeTemplateByObjectType.Request {
  public init(objectType: String) {
    self.objectType = objectType
  }
}

extension Anytype_Rpc.MakeTemplateByObjectType.Response {
  public init(error: Anytype_Rpc.MakeTemplateByObjectType.Response.Error, id: String) {
    self.error = error
    self.id = id
  }
}

extension Anytype_Rpc.MakeTemplateByObjectType.Response.Error {
  public init(code: Anytype_Rpc.MakeTemplateByObjectType.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Metrics.SetParameters.Request {
  public init(platform: String) {
    self.platform = platform
  }
}

extension Anytype_Rpc.Metrics.SetParameters.Response {
  public init(error: Anytype_Rpc.Metrics.SetParameters.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Metrics.SetParameters.Response.Error {
  public init(code: Anytype_Rpc.Metrics.SetParameters.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Navigation.GetObjectInfoWithLinks.Request {
  public init(objectID: String, context: Anytype_Rpc.Navigation.Context) {
    self.objectID = objectID
    self.context = context
  }
}

extension Anytype_Rpc.Navigation.GetObjectInfoWithLinks.Response {
  public init(error: Anytype_Rpc.Navigation.GetObjectInfoWithLinks.Response.Error, object: Anytype_Model_ObjectInfoWithLinks) {
    self.error = error
    self.object = object
  }
}

extension Anytype_Rpc.Navigation.GetObjectInfoWithLinks.Response.Error {
  public init(code: Anytype_Rpc.Navigation.GetObjectInfoWithLinks.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Navigation.ListObjects.Request {
  public init(context: Anytype_Rpc.Navigation.Context, fullText: String, limit: Int32, offset: Int32) {
    self.context = context
    self.fullText = fullText
    self.limit = limit
    self.offset = offset
  }
}

extension Anytype_Rpc.Navigation.ListObjects.Response {
  public init(error: Anytype_Rpc.Navigation.ListObjects.Response.Error, objects: [Anytype_Model_ObjectInfo]) {
    self.error = error
    self.objects = objects
  }
}

extension Anytype_Rpc.Navigation.ListObjects.Response.Error {
  public init(code: Anytype_Rpc.Navigation.ListObjects.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.AddWithObjectId.Request {
  public init(objectID: String, payload: String) {
    self.objectID = objectID
    self.payload = payload
  }
}

extension Anytype_Rpc.Object.AddWithObjectId.Response {
  public init(error: Anytype_Rpc.Object.AddWithObjectId.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Object.AddWithObjectId.Response.Error {
  public init(code: Anytype_Rpc.Object.AddWithObjectId.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.FeaturedRelation.Add.Request {
  public init(contextID: String, relations: [String]) {
    self.contextID = contextID
    self.relations = relations
  }
}

extension Anytype_Rpc.Object.FeaturedRelation.Add.Response {
  public init(error: Anytype_Rpc.Object.FeaturedRelation.Add.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Object.FeaturedRelation.Add.Response.Error {
  public init(code: Anytype_Rpc.Object.FeaturedRelation.Add.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.FeaturedRelation.Remove.Request {
  public init(contextID: String, relations: [String]) {
    self.contextID = contextID
    self.relations = relations
  }
}

extension Anytype_Rpc.Object.FeaturedRelation.Remove.Response {
  public init(error: Anytype_Rpc.Object.FeaturedRelation.Remove.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Object.FeaturedRelation.Remove.Response.Error {
  public init(code: Anytype_Rpc.Object.FeaturedRelation.Remove.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.Graph.Edge {
  public init(source: String, target: String, name: String, type: Anytype_Rpc.Object.Graph.Edge.TypeEnum, description_p: String, iconImage: String, iconEmoji: String, hidden: Bool) {
    self.source = source
    self.target = target
    self.name = name
    self.type = type
    self.description_p = description_p
    self.iconImage = iconImage
    self.iconEmoji = iconEmoji
    self.hidden = hidden
  }
}

extension Anytype_Rpc.Object.Graph.Node {
  public init(id: String, type: String, name: String, layout: Int32, description_p: String, iconImage: String, iconEmoji: String, done: Bool, relationFormat: Int32, snippet: String) {
    self.id = id
    self.type = type
    self.name = name
    self.layout = layout
    self.description_p = description_p
    self.iconImage = iconImage
    self.iconEmoji = iconEmoji
    self.done = done
    self.relationFormat = relationFormat
    self.snippet = snippet
  }
}

extension Anytype_Rpc.Object.Graph.Request {
  public init(filters: [Anytype_Model_Block.Content.Dataview.Filter], limit: Int32, objectTypeFilter: [String]) {
    self.filters = filters
    self.limit = limit
    self.objectTypeFilter = objectTypeFilter
  }
}

extension Anytype_Rpc.Object.Graph.Response {
  public init(error: Anytype_Rpc.Object.Graph.Response.Error, nodes: [Anytype_Rpc.Object.Graph.Node], edges: [Anytype_Rpc.Object.Graph.Edge]) {
    self.error = error
    self.nodes = nodes
    self.edges = edges
  }
}

extension Anytype_Rpc.Object.Graph.Response.Error {
  public init(code: Anytype_Rpc.Object.Graph.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.IdsSubscribe.Request {
  public init(subID: String, ids: [String], keys: [String], ignoreWorkspace: String) {
    self.subID = subID
    self.ids = ids
    self.keys = keys
    self.ignoreWorkspace = ignoreWorkspace
  }
}

extension Anytype_Rpc.Object.IdsSubscribe.Response {
  public init(error: Anytype_Rpc.Object.IdsSubscribe.Response.Error, records: [SwiftProtobuf.Google_Protobuf_Struct], dependencies: [SwiftProtobuf.Google_Protobuf_Struct], subID: String) {
    self.error = error
    self.records = records
    self.dependencies = dependencies
    self.subID = subID
  }
}

extension Anytype_Rpc.Object.IdsSubscribe.Response.Error {
  public init(code: Anytype_Rpc.Object.IdsSubscribe.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.RelationAdd.Request {
  public init(contextID: String, relation: Anytype_Model_Relation) {
    self.contextID = contextID
    self.relation = relation
  }
}

extension Anytype_Rpc.Object.RelationAdd.Response {
  public init(error: Anytype_Rpc.Object.RelationAdd.Response.Error, event: Anytype_ResponseEvent, relationKey: String, relation: Anytype_Model_Relation) {
    self.error = error
    self.event = event
    self.relationKey = relationKey
    self.relation = relation
  }
}

extension Anytype_Rpc.Object.RelationAdd.Response.Error {
  public init(code: Anytype_Rpc.Object.RelationAdd.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.RelationDelete.Request {
  public init(contextID: String, relationKey: String) {
    self.contextID = contextID
    self.relationKey = relationKey
  }
}

extension Anytype_Rpc.Object.RelationDelete.Response {
  public init(error: Anytype_Rpc.Object.RelationDelete.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Object.RelationDelete.Response.Error {
  public init(code: Anytype_Rpc.Object.RelationDelete.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.RelationListAvailable.Request {
  public init(contextID: String) {
    self.contextID = contextID
  }
}

extension Anytype_Rpc.Object.RelationListAvailable.Response {
  public init(error: Anytype_Rpc.Object.RelationListAvailable.Response.Error, relations: [Anytype_Model_Relation]) {
    self.error = error
    self.relations = relations
  }
}

extension Anytype_Rpc.Object.RelationListAvailable.Response.Error {
  public init(code: Anytype_Rpc.Object.RelationListAvailable.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.RelationOptionAdd.Request {
  public init(contextID: String, relationKey: String, option: Anytype_Model_Relation.Option) {
    self.contextID = contextID
    self.relationKey = relationKey
    self.option = option
  }
}

extension Anytype_Rpc.Object.RelationOptionAdd.Response {
  public init(error: Anytype_Rpc.Object.RelationOptionAdd.Response.Error, event: Anytype_ResponseEvent, option: Anytype_Model_Relation.Option) {
    self.error = error
    self.event = event
    self.option = option
  }
}

extension Anytype_Rpc.Object.RelationOptionAdd.Response.Error {
  public init(code: Anytype_Rpc.Object.RelationOptionAdd.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.RelationOptionDelete.Request {
  public init(contextID: String, relationKey: String, optionID: String, confirmRemoveAllValuesInRecords: Bool) {
    self.contextID = contextID
    self.relationKey = relationKey
    self.optionID = optionID
    self.confirmRemoveAllValuesInRecords = confirmRemoveAllValuesInRecords
  }
}

extension Anytype_Rpc.Object.RelationOptionDelete.Response {
  public init(error: Anytype_Rpc.Object.RelationOptionDelete.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Object.RelationOptionDelete.Response.Error {
  public init(code: Anytype_Rpc.Object.RelationOptionDelete.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.RelationOptionUpdate.Request {
  public init(contextID: String, relationKey: String, option: Anytype_Model_Relation.Option) {
    self.contextID = contextID
    self.relationKey = relationKey
    self.option = option
  }
}

extension Anytype_Rpc.Object.RelationOptionUpdate.Response {
  public init(error: Anytype_Rpc.Object.RelationOptionUpdate.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Object.RelationOptionUpdate.Response.Error {
  public init(code: Anytype_Rpc.Object.RelationOptionUpdate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.RelationUpdate.Request {
  public init(contextID: String, relationKey: String, relation: Anytype_Model_Relation) {
    self.contextID = contextID
    self.relationKey = relationKey
    self.relation = relation
  }
}

extension Anytype_Rpc.Object.RelationUpdate.Response {
  public init(error: Anytype_Rpc.Object.RelationUpdate.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Object.RelationUpdate.Response.Error {
  public init(code: Anytype_Rpc.Object.RelationUpdate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.Search.Request {
  public init(
    filters: [Anytype_Model_Block.Content.Dataview.Filter], sorts: [Anytype_Model_Block.Content.Dataview.Sort], fullText: String, offset: Int32, limit: Int32, objectTypeFilter: [String],
    keys: [String]
  ) {
    self.filters = filters
    self.sorts = sorts
    self.fullText = fullText
    self.offset = offset
    self.limit = limit
    self.objectTypeFilter = objectTypeFilter
    self.keys = keys
  }
}

extension Anytype_Rpc.Object.Search.Response {
  public init(error: Anytype_Rpc.Object.Search.Response.Error, records: [SwiftProtobuf.Google_Protobuf_Struct]) {
    self.error = error
    self.records = records
  }
}

extension Anytype_Rpc.Object.Search.Response.Error {
  public init(code: Anytype_Rpc.Object.Search.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.SearchSubscribe.Request {
  public init(
    subID: String, filters: [Anytype_Model_Block.Content.Dataview.Filter], sorts: [Anytype_Model_Block.Content.Dataview.Sort], limit: Int64, offset: Int64, keys: [String], afterID: String,
    beforeID: String, source: [String], ignoreWorkspace: String, noDepSubscription: Bool
  ) {
    self.subID = subID
    self.filters = filters
    self.sorts = sorts
    self.limit = limit
    self.offset = offset
    self.keys = keys
    self.afterID = afterID
    self.beforeID = beforeID
    self.source = source
    self.ignoreWorkspace = ignoreWorkspace
    self.noDepSubscription = noDepSubscription
  }
}

extension Anytype_Rpc.Object.SearchSubscribe.Response {
  public init(
    error: Anytype_Rpc.Object.SearchSubscribe.Response.Error, records: [SwiftProtobuf.Google_Protobuf_Struct], dependencies: [SwiftProtobuf.Google_Protobuf_Struct], subID: String,
    counters: Anytype_Event.Object.Subscription.Counters
  ) {
    self.error = error
    self.records = records
    self.dependencies = dependencies
    self.subID = subID
    self.counters = counters
  }
}

extension Anytype_Rpc.Object.SearchSubscribe.Response.Error {
  public init(code: Anytype_Rpc.Object.SearchSubscribe.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.SearchUnsubscribe.Request {
  public init(subIds: [String]) {
    self.subIds = subIds
  }
}

extension Anytype_Rpc.Object.SearchUnsubscribe.Response {
  public init(error: Anytype_Rpc.Object.SearchUnsubscribe.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Object.SearchUnsubscribe.Response.Error {
  public init(code: Anytype_Rpc.Object.SearchUnsubscribe.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.SetIsArchived.Request {
  public init(contextID: String, isArchived: Bool) {
    self.contextID = contextID
    self.isArchived = isArchived
  }
}

extension Anytype_Rpc.Object.SetIsArchived.Response {
  public init(error: Anytype_Rpc.Object.SetIsArchived.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Object.SetIsArchived.Response.Error {
  public init(code: Anytype_Rpc.Object.SetIsArchived.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.SetIsFavorite.Request {
  public init(contextID: String, isFavorite: Bool) {
    self.contextID = contextID
    self.isFavorite = isFavorite
  }
}

extension Anytype_Rpc.Object.SetIsFavorite.Response {
  public init(error: Anytype_Rpc.Object.SetIsFavorite.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Object.SetIsFavorite.Response.Error {
  public init(code: Anytype_Rpc.Object.SetIsFavorite.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.SetLayout.Request {
  public init(contextID: String, layout: Anytype_Model_ObjectType.Layout) {
    self.contextID = contextID
    self.layout = layout
  }
}

extension Anytype_Rpc.Object.SetLayout.Response {
  public init(error: Anytype_Rpc.Object.SetLayout.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.Object.SetLayout.Response.Error {
  public init(code: Anytype_Rpc.Object.SetLayout.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.ShareByLink.Request {
  public init(objectID: String) {
    self.objectID = objectID
  }
}

extension Anytype_Rpc.Object.ShareByLink.Response {
  public init(link: String, error: Anytype_Rpc.Object.ShareByLink.Response.Error) {
    self.link = link
    self.error = error
  }
}

extension Anytype_Rpc.Object.ShareByLink.Response.Error {
  public init(code: Anytype_Rpc.Object.ShareByLink.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Object.ToSet.Request {
  public init(contextID: String, source: [String]) {
    self.contextID = contextID
    self.source = source
  }
}

extension Anytype_Rpc.Object.ToSet.Response {
  public init(error: Anytype_Rpc.Object.ToSet.Response.Error, setID: String) {
    self.error = error
    self.setID = setID
  }
}

extension Anytype_Rpc.Object.ToSet.Response.Error {
  public init(code: Anytype_Rpc.Object.ToSet.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectDuplicate.Request {
  public init(contextID: String) {
    self.contextID = contextID
  }
}

extension Anytype_Rpc.ObjectDuplicate.Response {
  public init(error: Anytype_Rpc.ObjectDuplicate.Response.Error, id: String) {
    self.error = error
    self.id = id
  }
}

extension Anytype_Rpc.ObjectDuplicate.Response.Error {
  public init(code: Anytype_Rpc.ObjectDuplicate.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectList.Delete.Request {
  public init(objectIds: [String]) {
    self.objectIds = objectIds
  }
}

extension Anytype_Rpc.ObjectList.Delete.Response {
  public init(error: Anytype_Rpc.ObjectList.Delete.Response.Error, event: Anytype_ResponseEvent) {
    self.error = error
    self.event = event
  }
}

extension Anytype_Rpc.ObjectList.Delete.Response.Error {
  public init(code: Anytype_Rpc.ObjectList.Delete.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectList.Set.IsArchived.Request {
  public init(objectIds: [String], isArchived: Bool) {
    self.objectIds = objectIds
    self.isArchived = isArchived
  }
}

extension Anytype_Rpc.ObjectList.Set.IsArchived.Response {
  public init(error: Anytype_Rpc.ObjectList.Set.IsArchived.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.ObjectList.Set.IsArchived.Response.Error {
  public init(code: Anytype_Rpc.ObjectList.Set.IsArchived.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectList.Set.IsFavorite.Request {
  public init(objectIds: [String], isFavorite: Bool) {
    self.objectIds = objectIds
    self.isFavorite = isFavorite
  }
}

extension Anytype_Rpc.ObjectList.Set.IsFavorite.Response {
  public init(error: Anytype_Rpc.ObjectList.Set.IsFavorite.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.ObjectList.Set.IsFavorite.Response.Error {
  public init(code: Anytype_Rpc.ObjectList.Set.IsFavorite.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectType.Create.Request {
  public init(objectType: Anytype_Model_ObjectType) {
    self.objectType = objectType
  }
}

extension Anytype_Rpc.ObjectType.Create.Response {
  public init(error: Anytype_Rpc.ObjectType.Create.Response.Error, objectType: Anytype_Model_ObjectType) {
    self.error = error
    self.objectType = objectType
  }
}

extension Anytype_Rpc.ObjectType.Create.Response.Error {
  public init(code: Anytype_Rpc.ObjectType.Create.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectType.List.Response {
  public init(error: Anytype_Rpc.ObjectType.List.Response.Error, objectTypes: [Anytype_Model_ObjectType]) {
    self.error = error
    self.objectTypes = objectTypes
  }
}

extension Anytype_Rpc.ObjectType.List.Response.Error {
  public init(code: Anytype_Rpc.ObjectType.List.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectType.Relation.Add.Request {
  public init(objectTypeURL: String, relations: [Anytype_Model_Relation]) {
    self.objectTypeURL = objectTypeURL
    self.relations = relations
  }
}

extension Anytype_Rpc.ObjectType.Relation.Add.Response {
  public init(error: Anytype_Rpc.ObjectType.Relation.Add.Response.Error, relations: [Anytype_Model_Relation]) {
    self.error = error
    self.relations = relations
  }
}

extension Anytype_Rpc.ObjectType.Relation.Add.Response.Error {
  public init(code: Anytype_Rpc.ObjectType.Relation.Add.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectType.Relation.List.Request {
  public init(objectTypeURL: String, appendRelationsFromOtherTypes: Bool) {
    self.objectTypeURL = objectTypeURL
    self.appendRelationsFromOtherTypes = appendRelationsFromOtherTypes
  }
}

extension Anytype_Rpc.ObjectType.Relation.List.Response {
  public init(error: Anytype_Rpc.ObjectType.Relation.List.Response.Error, relations: [Anytype_Model_Relation]) {
    self.error = error
    self.relations = relations
  }
}

extension Anytype_Rpc.ObjectType.Relation.List.Response.Error {
  public init(code: Anytype_Rpc.ObjectType.Relation.List.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectType.Relation.Remove.Request {
  public init(objectTypeURL: String, relationKey: String) {
    self.objectTypeURL = objectTypeURL
    self.relationKey = relationKey
  }
}

extension Anytype_Rpc.ObjectType.Relation.Remove.Response {
  public init(error: Anytype_Rpc.ObjectType.Relation.Remove.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.ObjectType.Relation.Remove.Response.Error {
  public init(code: Anytype_Rpc.ObjectType.Relation.Remove.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.ObjectType.Relation.Update.Request {
  public init(objectTypeURL: String, relation: Anytype_Model_Relation) {
    self.objectTypeURL = objectTypeURL
    self.relation = relation
  }
}

extension Anytype_Rpc.ObjectType.Relation.Update.Response {
  public init(error: Anytype_Rpc.ObjectType.Relation.Update.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.ObjectType.Relation.Update.Response.Error {
  public init(code: Anytype_Rpc.ObjectType.Relation.Update.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Page.Create.Request {
  public init(details: SwiftProtobuf.Google_Protobuf_Struct) {
    self.details = details
  }
}

extension Anytype_Rpc.Page.Create.Response {
  public init(error: Anytype_Rpc.Page.Create.Response.Error, pageID: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.pageID = pageID
    self.event = event
  }
}

extension Anytype_Rpc.Page.Create.Response.Error {
  public init(code: Anytype_Rpc.Page.Create.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Ping.Request {
  public init(index: Int32, numberOfEventsToSend: Int32) {
    self.index = index
    self.numberOfEventsToSend = numberOfEventsToSend
  }
}

extension Anytype_Rpc.Ping.Response {
  public init(error: Anytype_Rpc.Ping.Response.Error, index: Int32) {
    self.error = error
    self.index = index
  }
}

extension Anytype_Rpc.Ping.Response.Error {
  public init(code: Anytype_Rpc.Ping.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Process.Cancel.Request {
  public init(id: String) {
    self.id = id
  }
}

extension Anytype_Rpc.Process.Cancel.Response {
  public init(error: Anytype_Rpc.Process.Cancel.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Process.Cancel.Response.Error {
  public init(code: Anytype_Rpc.Process.Cancel.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Set.Create.Request {
  public init(source: [String], details: SwiftProtobuf.Google_Protobuf_Struct, templateID: String) {
    self.source = source
    self.details = details
    self.templateID = templateID
  }
}

extension Anytype_Rpc.Set.Create.Response {
  public init(error: Anytype_Rpc.Set.Create.Response.Error, id: String, event: Anytype_ResponseEvent) {
    self.error = error
    self.id = id
    self.event = event
  }
}

extension Anytype_Rpc.Set.Create.Response.Error {
  public init(code: Anytype_Rpc.Set.Create.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Shutdown.Response {
  public init(error: Anytype_Rpc.Shutdown.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Shutdown.Response.Error {
  public init(code: Anytype_Rpc.Shutdown.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.UnsplashDownload.Request {
  public init(pictureID: String) {
    self.pictureID = pictureID
  }
}

extension Anytype_Rpc.UnsplashDownload.Response {
  public init(error: Anytype_Rpc.UnsplashDownload.Response.Error, hash: String) {
    self.error = error
    self.hash = hash
  }
}

extension Anytype_Rpc.UnsplashDownload.Response.Error {
  public init(code: Anytype_Rpc.UnsplashDownload.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.UnsplashSearch.Request {
  public init(query: String, limit: Int32) {
    self.query = query
    self.limit = limit
  }
}

extension Anytype_Rpc.UnsplashSearch.Response {
  public init(error: Anytype_Rpc.UnsplashSearch.Response.Error, pictures: [Anytype_Rpc.UnsplashSearch.Response.Picture]) {
    self.error = error
    self.pictures = pictures
  }
}

extension Anytype_Rpc.UnsplashSearch.Response.Error {
  public init(code: Anytype_Rpc.UnsplashSearch.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.UnsplashSearch.Response.Picture {
  public init(id: String, url: String, artist: String, artistURL: String) {
    self.id = id
    self.url = url
    self.artist = artist
    self.artistURL = artistURL
  }
}

extension Anytype_Rpc.UploadFile.Request {
  public init(url: String, localPath: String, type: Anytype_Model_Block.Content.File.TypeEnum, disableEncryption: Bool, style: Anytype_Model_Block.Content.File.Style) {
    self.url = url
    self.localPath = localPath
    self.type = type
    self.disableEncryption = disableEncryption
    self.style = style
  }
}

extension Anytype_Rpc.UploadFile.Response {
  public init(error: Anytype_Rpc.UploadFile.Response.Error, hash: String) {
    self.error = error
    self.hash = hash
  }
}

extension Anytype_Rpc.UploadFile.Response.Error {
  public init(code: Anytype_Rpc.UploadFile.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Version.Get.Response {
  public init(error: Anytype_Rpc.Version.Get.Response.Error, version: String, details: String) {
    self.error = error
    self.version = version
    self.details = details
  }
}

extension Anytype_Rpc.Version.Get.Response.Error {
  public init(code: Anytype_Rpc.Version.Get.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Wallet.Convert.Request {
  public init(mnemonic: String, entropy: String) {
    self.mnemonic = mnemonic
    self.entropy = entropy
  }
}

extension Anytype_Rpc.Wallet.Convert.Response {
  public init(error: Anytype_Rpc.Wallet.Convert.Response.Error, entropy: String, mnemonic: String) {
    self.error = error
    self.entropy = entropy
    self.mnemonic = mnemonic
  }
}

extension Anytype_Rpc.Wallet.Convert.Response.Error {
  public init(code: Anytype_Rpc.Wallet.Convert.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Wallet.Create.Request {
  public init(rootPath: String) {
    self.rootPath = rootPath
  }
}

extension Anytype_Rpc.Wallet.Create.Response {
  public init(error: Anytype_Rpc.Wallet.Create.Response.Error, mnemonic: String) {
    self.error = error
    self.mnemonic = mnemonic
  }
}

extension Anytype_Rpc.Wallet.Create.Response.Error {
  public init(code: Anytype_Rpc.Wallet.Create.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Wallet.Recover.Request {
  public init(rootPath: String, mnemonic: String) {
    self.rootPath = rootPath
    self.mnemonic = mnemonic
  }
}

extension Anytype_Rpc.Wallet.Recover.Response {
  public init(error: Anytype_Rpc.Wallet.Recover.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Wallet.Recover.Response.Error {
  public init(code: Anytype_Rpc.Wallet.Recover.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Workspace.Create.Request {
  public init(name: String) {
    self.name = name
  }
}

extension Anytype_Rpc.Workspace.Create.Response {
  public init(error: Anytype_Rpc.Workspace.Create.Response.Error, workspaceID: String) {
    self.error = error
    self.workspaceID = workspaceID
  }
}

extension Anytype_Rpc.Workspace.Create.Response.Error {
  public init(code: Anytype_Rpc.Workspace.Create.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Workspace.GetAll.Response {
  public init(error: Anytype_Rpc.Workspace.GetAll.Response.Error, workspaceIds: [String]) {
    self.error = error
    self.workspaceIds = workspaceIds
  }
}

extension Anytype_Rpc.Workspace.GetAll.Response.Error {
  public init(code: Anytype_Rpc.Workspace.GetAll.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Workspace.GetCurrent.Response {
  public init(error: Anytype_Rpc.Workspace.GetCurrent.Response.Error, workspaceID: String) {
    self.error = error
    self.workspaceID = workspaceID
  }
}

extension Anytype_Rpc.Workspace.GetCurrent.Response.Error {
  public init(code: Anytype_Rpc.Workspace.GetCurrent.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Workspace.Select.Request {
  public init(workspaceID: String) {
    self.workspaceID = workspaceID
  }
}

extension Anytype_Rpc.Workspace.Select.Response {
  public init(error: Anytype_Rpc.Workspace.Select.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Workspace.Select.Response.Error {
  public init(code: Anytype_Rpc.Workspace.Select.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}

extension Anytype_Rpc.Workspace.SetIsHighlighted.Request {
  public init(objectID: String, isHighlighted: Bool) {
    self.objectID = objectID
    self.isHighlighted = isHighlighted
  }
}

extension Anytype_Rpc.Workspace.SetIsHighlighted.Response {
  public init(error: Anytype_Rpc.Workspace.SetIsHighlighted.Response.Error) {
    self.error = error
  }
}

extension Anytype_Rpc.Workspace.SetIsHighlighted.Response.Error {
  public init(code: Anytype_Rpc.Workspace.SetIsHighlighted.Response.Error.Code, description_p: String) {
    self.code = code
    self.description_p = description_p
  }
}
