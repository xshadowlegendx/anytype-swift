import Foundation
import BlocksModels
import SwiftProtobuf
import UIKit

final class RelationsBuilder {
    
    private let scope: [RelationMetadata.Scope]
    private let storage: ObjectDetailsStorage
    
    init(scope: [RelationMetadata.Scope] = [.object], storage: ObjectDetailsStorage = ObjectDetailsStorage.shared) {
        self.scope = scope
        self.storage = storage
    }

    // MARK: - Private variables
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }()
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ""
        return formatter
    }()
    
    // MARK: - Internal functions
    
    func parsedRelations(
        relationMetadatas: [RelationMetadata],
        objectId: BlockId,
        isObjectLocked: Bool
    ) -> ParsedRelations {
        guard
            let objectDetails = storage.get(id: objectId)
        else {
            return .empty
        }
        
        var featuredRelations: [Relation] = []
        var otherRelations: [Relation] = []
        
        relationMetadatas.forEach { relationMetadata in
            guard !relationMetadata.isHidden, scope.contains(relationMetadata.scope) else { return }
            
            let value = relation(
                relationMetadata: relationMetadata,
                details: objectDetails,
                isObjectLocked: isObjectLocked
            )
            
            if value.isFeatured {
                featuredRelations.append(value)
            } else {
                otherRelations.append(value)
            }
        }
        
        return ParsedRelations(featuredRelations: featuredRelations, otherRelations: otherRelations)
    }
    
}

// MARK: - Private extension

private extension RelationsBuilder {
    
    func relation(
        relationMetadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        switch relationMetadata.format {
        case .longText:
            return textRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .shortText:
            return textRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .number:
            return numberRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .status:
            return statusRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .date:
            return dateRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .file:
            return fileRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .checkbox:
            return checkboxRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .url:
            return urlRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .email:
            return emailRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .phone:
            return phoneRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .tag:
            return tagRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .object:
            return objectRelation(
                metadata: relationMetadata,
                details: details,
                isObjectLocked: isObjectLocked
            )
        case .unrecognized:
            return .text(
                Relation.Text(
                    id: relationMetadata.id,
                    name: relationMetadata.name,
                    isFeatured: relationMetadata.isFeatured(details: details),
                    isEditable: relationMetadata.isEditable(objectLocked: isObjectLocked),
                    isBundled: relationMetadata.isBundled,
                    value: Loc.unsupportedValue
                )
            )
        }
    }
    
    func textRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        .text(
            Relation.Text(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                value: details.values[metadata.key]?.stringValue
            )
        )
    }
    
    func numberRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        let numberValue: String? = {
            let value = details.values[metadata.key]
            
            guard let number = value?.safeDoubleValue else { return nil }
            
            return numberFormatter.string(from: NSNumber(floatLiteral: number))
        }()
        
        return .number(
            Relation.Text(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                value: numberValue
            )
        )
    }
    
    func phoneRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        .phone(
            Relation.Text(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                value: details.values[metadata.key]?.stringValue
            )
        )
    }
    
    func emailRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        .email(
            Relation.Text(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                value: details.values[metadata.key]?.stringValue
            )
        )
    }
    
    func urlRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        .url(
            Relation.Text(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                value: details.values[metadata.key]?.stringValue
            )
        )
    }
    
    func statusRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        let options: [Relation.Status.Option] = metadata.selections.map {
            Relation.Status.Option(option: $0)
        }
        
        let selectedOption: Relation.Status.Option? = {
            let value = details.values[metadata.key]
            
            guard
                let optionId = value?.unwrapedListValue.stringValue, optionId.isNotEmpty
            else { return nil }
            
            return options.first { $0.id == optionId }
        }()
        
        return .status(
            Relation.Status(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                value: selectedOption,
                allOptions: options
            )
        )
    }
    
    func dateRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        let value: DateRelationValue? = {
            let value = details.values[metadata.key]
            
            guard let timeInterval = value?.safeDoubleValue, !timeInterval.isZero
            else { return nil }
            
            let date = Date(timeIntervalSince1970: timeInterval)
            return DateRelationValue(date: date, text: dateFormatter.string(from: date))
        }()
        
        return .date(
            Relation.Date(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                value: value
            )
        )
    }
    
    func checkboxRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        .checkbox(
            Relation.Checkbox(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                value: details.values[metadata.key]?.boolValue ?? false
            )
        )
    }
    
    func tagRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        let tags: [Relation.Tag.Option] = metadata.selections.map { Relation.Tag.Option(option: $0) }
        
        let selectedTags: [Relation.Tag.Option] = {
            let value = details.values[metadata.key]
            guard let value = value else { return [] }
            
            let selectedTagIds: [String] = value.listValue.values.compactMap {
                let tagId = $0.stringValue
                return tagId.isEmpty ? nil : tagId
            }
            
            return selectedTagIds.compactMap { id in
                tags.first { $0.id == id }
            }
        }()
        
        return .tag(
            Relation.Tag(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                selectedTags: selectedTags,
                allTags: tags
            )
        )
    }
    
    func objectRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        let objectOptions: [Relation.Object.Option] = {
            let value = details.values[metadata.key]
            guard let value = value else { return [] }
            
            let values: [Google_Protobuf_Value] = {
                if case let .listValue(listValue) = value.kind {
                    return listValue.values
                }
                
                return [value]
            }()
            
            let objectDetails: [ObjectDetails] = values.compactMap {
                return storage.get(id: $0.stringValue)
            }

            let objectOptions: [Relation.Object.Option] = objectDetails.map { objectDetail in
                let name = objectDetail.title
                let icon: ObjectIconImage = {
                    if let objectIcon = objectDetail.objectIconImage {
                        return objectIcon
                    }
                    
                    return .placeholder(name.first)
                }()
                
                return Relation.Object.Option(
                    id: objectDetail.id,
                    icon: icon,
                    title: name,
                    type: objectDetail.objectType.name,
                    isArchived: objectDetail.isArchived,
                    isDeleted: objectDetail.isDeleted
                )
            }
            
            return objectOptions
        }()
        
        return .object(
            Relation.Object(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                selectedObjects: objectOptions,
                limitedObjectTypes: metadata.objectTypes
            )
        )
    }
    
    func fileRelation(
        metadata: RelationMetadata,
        details: ObjectDetails,
        isObjectLocked: Bool
    ) -> Relation {
        let fileOptions: [Relation.File.Option] = {
            let value = details.values[metadata.key]
            guard let value = value else { return [] }
            
            let objectDetails: [ObjectDetails] = value.listValue.values.compactMap {
                return storage.get(id: $0.stringValue)
            }

            let objectOptions: [Relation.File.Option] = objectDetails.map { objectDetail in
                let fileName: String = {
                    let name = objectDetail.name
                    let fileExt = objectDetail.values[BundledRelationKey.fileExt.rawValue]
                    let fileExtString = fileExt?.stringValue
                    
                    guard
                        let fileExtString = fileExtString, fileExtString.isNotEmpty
                    else { return name }
                    
                    return "\(name).\(fileExtString)"
                }()
                
                let icon: ObjectIconImage = {
                    if let objectIconType = objectDetail.icon {
                        return .icon(objectIconType)
                    }
                    
                    let fileMimeType = objectDetail.values[BundledRelationKey.fileMimeType.rawValue]?.stringValue
                    let fileName = objectDetail.values[BundledRelationKey.name.rawValue]?.stringValue

                    guard let fileMimeType = fileMimeType, let fileName = fileName else {
                        return .staticImage(FileIconConstants.other)
                    }
                    
                    return .staticImage(BlockFileIconBuilder.convert(mime: fileMimeType, fileName: fileName))
                }()
                
                return Relation.File.Option(
                    id: objectDetail.id,
                    icon: icon,
                    title: fileName
                )
            }
            
            return objectOptions
        }()
        
        return .file(
            Relation.File(
                id: metadata.id,
                name: metadata.name,
                isFeatured: metadata.isFeatured(details: details),
                isEditable: metadata.isEditable(objectLocked: isObjectLocked),
                isBundled: metadata.isBundled,
                files: fileOptions
            )
        )
    }
    
}

extension RelationMetadata.Format {
    
    var hint: String {
        switch self {
        case .longText:
            return Loc.enterText
        case .shortText:
            return Loc.enterText
        case .number:
            return Loc.enterNumber
        case .date:
            return Loc.enterDate
        case .url:
            return Loc.enterURL
        case .email:
            return Loc.enterEMail
        case .phone:
            return Loc.enterPhone
        case .status:
            return Loc.selectStatus
        case .tag:
            return Loc.selectTags
        case .file:
            return Loc.selectFiles
        case .object:
            return Loc.selectObjects
        case .checkbox:
            return ""
        case .unrecognized:
            return Loc.enterValue
        }
    }
    
}

private extension RelationMetadata {
    
    func isFeatured(details: ObjectDetails) -> Bool {
        details.featuredRelations.contains(self.id)
    }
    
    func isEditable(objectLocked: Bool) -> Bool {
        guard !objectLocked else { return false }
        
        return !self.isReadOnly
    }
    
}
