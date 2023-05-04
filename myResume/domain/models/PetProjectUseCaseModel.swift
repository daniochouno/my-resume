//
//  PetProjectUseCaseModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import Foundation

struct PetProjectUseCaseModel: Decodable {
    let titleKey: String
    let subtitleKey: String
    let iconUrl: String
    let linkAppStore: String?
    let linkPlayStore: String?
    let linkWeb: String?
    let downloads: String?
}

extension PetProjectUseCaseModel {
    init(from firestoreModel: PetProjectFirestoreModel) {
        self.titleKey = firestoreModel.fields.titleKey.stringValue
        self.subtitleKey = firestoreModel.fields.subtitleKey.stringValue
        self.iconUrl = firestoreModel.fields.iconUrl.stringValue
        self.linkAppStore = firestoreModel.fields.linkAppStore?.stringValue
        self.linkPlayStore = firestoreModel.fields.linkPlayStore?.stringValue
        self.linkWeb = firestoreModel.fields.linkWeb?.stringValue
        self.downloads = firestoreModel.fields.downloads?.stringValue
    }
}
