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
    let headerColor: String
    let linkAppStore: String?
    let linkPlayStore: String?
    let linkWeb: String?
    let downloads: Int?
}

extension PetProjectUseCaseModel {
    init(from firestoreModel: PetProjectFirestoreModel) {
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
