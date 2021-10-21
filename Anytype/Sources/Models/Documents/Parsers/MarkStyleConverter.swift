import BlocksModels
import ProtobufMessages
import AnytypeCore

enum MarkStyleActionConverter {
    
    static func asModel(tuple: MiddlewareTuple, detailsStorage: ObjectDetailsStorageProtocol) -> MarkStyleAction? {
        switch tuple.attribute {
        case .strikethrough:
            return .strikethrough(true)
        case .keyboard:
            return .keyboard(true)
        case .italic:
            return .italic(true)
        case .bold:
            return .bold(true)
        case .underscored:
            return .underscored(true)
        case .link:
            return .link(URL(string: tuple.value))

        case .textColor:
            guard let color = MiddlewareColor(rawValue: tuple.value)?.color(background: false) else {
                return nil
            }
            return .textColor(color)

        case .backgroundColor:
            guard let color = MiddlewareColor(rawValue: tuple.value)?.color(background: true) else {
                return nil
            }
            return .backgroundColor(color)
        case .mention:
            guard let details = detailsStorage.get(id: tuple.value) else {
                return .mention(image: nil, blockId: tuple.value)
            }
            
            return .mention(image: details.objectIconImage, blockId: tuple.value)
        case .UNRECOGNIZED(let value):
            anytypeAssertionFailure("Unrecognized markup \(value)")
            return nil
        case .emoji:
            anytypeAssertionFailure("Unrecognized markup emoji")
            return nil
        case .object:
            anytypeAssertionFailure("Unrecognized markup object")
            return nil
        }
    }
}
