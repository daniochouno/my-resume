//
//  PetProjectUseCaseModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import Foundation

struct PetProjectUseCaseModel: Decodable {
    let type: RepositoryDataSourceTypeModel
    let items: [PetProjectItemUseCaseModel]
}

struct PetProjectItemUseCaseModel: Decodable {
    let documentId: String
    let titleKey: String
    let subtitleKey: String
    let iconUrl: String
    let headerColor: String
    let linkAppStore: String?
    let linkPlayStore: String?
    let linkWeb: String?
    let downloads: Int?
}

extension PetProjectItemUseCaseModel {
    init(from firestoreModel: PetProjectFirestoreModel) {
        let documentIdUrl = URL(string: firestoreModel.name)!
        self.documentId = documentIdUrl.lastPathComponent
        self.titleKey = firestoreModel.fields.titleKey.stringValue
        self.subtitleKey = firestoreModel.fields.subtitleKey.stringValue
        self.iconUrl = firestoreModel.fields.iconUrl.stringValue
        self.headerColor = firestoreModel.fields.headerColor.stringValue
        self.linkAppStore = firestoreModel.fields.linkAppStore?.stringValue
        self.linkPlayStore = firestoreModel.fields.linkPlayStore?.stringValue
        self.linkWeb = firestoreModel.fields.linkWeb?.stringValue
        if let downloads = firestoreModel.fields.downloads?.integerValue {
            self.downloads = Int(downloads)
        } else {
            self.downloads = nil
        }
    }
}
