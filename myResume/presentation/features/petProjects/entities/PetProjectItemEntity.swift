//
//  PetProjectItemEntity.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

struct PetProjectItemEntity: Identifiable, Equatable {
    let id: UUID
    let documentId: String
    let titleKey: String
    let subtitleKey: String
    let iconUrl: String
    let headerColor: String
    let linkAppStore: String?
    let linkPlayStore: String?
    let linkWeb: String?
    let downloads: String?
}

extension PetProjectItemEntity {
    init(from itemUseCaseModel: PetProjectItemUseCaseModel) {
        self.id = UUID()
        self.documentId = itemUseCaseModel.documentId
        self.titleKey = itemUseCaseModel.titleKey
        self.subtitleKey = itemUseCaseModel.subtitleKey
        self.iconUrl = itemUseCaseModel.iconUrl
        self.headerColor = itemUseCaseModel.headerColor
        self.linkAppStore = itemUseCaseModel.linkAppStore
        self.linkPlayStore = itemUseCaseModel.linkPlayStore
        self.linkWeb = itemUseCaseModel.linkWeb
        
        if let downloads = itemUseCaseModel.downloads {
            if downloads >= 0 && downloads < 1000 {
                self.downloads = String(downloads)
            } else if downloads >= 1000 && downloads < 1000000 {
                let kDownloads = downloads/1000
                self.downloads = String(kDownloads) + "k"
            } else {
                let mDownloads = downloads/1000000
                self.downloads = String(mDownloads) + "M"
            }
        } else {
            self.downloads = nil
        }
    }
}
