//
//  PetProjectEntity.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

struct PetProjectEntity: Identifiable, Equatable {
    let id: UUID
    let titleKey: String
    let subtitleKey: String
    let iconUrl: String
    let headerColor: String
    let linkAppStore: String?
    let linkPlayStore: String?
    let linkWeb: String?
    let downloads: String?
}

extension PetProjectEntity {
    init(from useCaseModel: PetProjectUseCaseModel) {
        self.id = UUID()
        self.titleKey = useCaseModel.titleKey
        self.subtitleKey = useCaseModel.subtitleKey
        self.iconUrl = useCaseModel.iconUrl
        self.headerColor = useCaseModel.headerColor
        self.linkAppStore = useCaseModel.linkAppStore
        self.linkPlayStore = useCaseModel.linkPlayStore
        self.linkWeb = useCaseModel.linkWeb
        
        if let downloads = useCaseModel.downloads {
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
