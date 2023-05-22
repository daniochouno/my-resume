//
//  PetProjectDetailsUseCaseModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import Foundation

struct PetProjectDetailsUseCaseModel: Decodable {
    let type: RepositoryDataSourceTypeModel
    let item: PetProjectDetailsItemUseCaseModel
}

struct PetProjectDetailsItemUseCaseModel: Decodable {
    let titleKey: String
    let subtitleKey: String
    let iconUrl: String
    let headerColor: String
    let downloads: Int?
    let linkAppStore: String?
    let linkPlayStore: String?
}

extension PetProjectDetailsItemUseCaseModel {
    init(from firestoreModel: PetProjectDetailsFirestoreModel) {
        self.titleKey = firestoreModel.fields.titleKey.stringValue
        self.subtitleKey = firestoreModel.fields.subtitleKey.stringValue
        self.iconUrl = firestoreModel.fields.iconUrl.stringValue
        self.headerColor = firestoreModel.fields.headerColor.stringValue
        self.downloads = Int(firestoreModel.fields.downloads.integerValue)
        if let linkAppStore = firestoreModel.fields.linkAppStore?.stringValue {
            self.linkAppStore = linkAppStore
        } else {
            self.linkAppStore = nil
        }
        if let linkPlayStore = firestoreModel.fields.linkPlayStore?.stringValue {
            self.linkPlayStore = linkPlayStore
        } else {
            self.linkPlayStore = nil
        }
    }
}
