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
        self.linkAppStore = useCaseModel.linkAppStore
        self.linkPlayStore = useCaseModel.linkPlayStore
        self.linkWeb = useCaseModel.linkWeb
        self.downloads = useCaseModel.downloads
    }
}
