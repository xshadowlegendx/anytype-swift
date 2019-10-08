//
//  DocumentViewModel.swift
//  AnyType
//
//  Created by Denis Batvinkin on 19.09.2019.
//  Copyright © 2019 AnyType. All rights reserved.
//

import Foundation

class DocumentViewModel: ObservableObject {
    private let documentService = TestDocumentService()
    
    @Published var error: String?
    @Published var blocksViewsBuilders: [BlockViewRowBuilderProtocol]?
    
    init(documentId: String?) {
        obtainDocument(documentId: documentId)
    }
    
    func addBlock(content: BlockType, afterBlock: Int) {
        let index = afterBlock + 1
        
//        documentService.addBlock(content: content, by: index, for: documentModel) { [weak self] result in
//            guard let strongSelf = self else { return }
//
//            switch result {
//            case .success(let newDocumentModel):
//                strongSelf.documentModel = newDocumentModel
//            case .failure(let error):
//                strongSelf.error = error.localizedDescription
//            }
//        }
    }
    
}
 
extension DocumentViewModel {
    
    private func obtainDocument(documentId: String?) {
        let completion = { [weak self] (result: Result<Documents.Document, Error>) in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let document):
                strongSelf.createblocksViewsBuilders(document: document)
            case .failure(let error):
                strongSelf.error = error.localizedDescription
            }
        }
        
        /// if document exists obtain it or create new one
        if let documentId = documentId {
            documentService.obtainDocument(id: documentId, completion: completion)
        } else {
            documentService.createNewDocument(completion: completion)
        }
    }
    
    // TODO: Refact when middle will be ready
    private func createblocksViewsBuilders(document: Documents.Document) {
        blocksViewsBuilders = [BlockViewRowBuilderProtocol]()
        
        // TODO: Maybe we need to create some fabric for resolver?
        let resolver: (Block) -> BlockViewRowBuilderProtocol = { block in
            switch block.type {
            case .text:
                return TextBlockViewModel(block: block)
            case .image:
                return TextBlockViewModel(block: block)
            case .video:
                return TextBlockViewModel(block: block)
            }
        }
        blocksViewsBuilders = document.blocks.map { resolver($0) }
    }
    
}
