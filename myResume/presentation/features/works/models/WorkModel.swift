//
//  WorkModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

struct WorkModel: Identifiable, Equatable {
    let id: UUID
    let documentId: String
    let titleKey: String
    let companyKey: String
    let companyLogoUrl: String
    let locationKey: String
    let startDate: Date
    let endDate: Date?
}

extension WorkModel {
    init(from itemUseCaseModel: WorkItemUseCaseModel) {
        self.id = UUID()
        self.documentId = itemUseCaseModel.documentId
        self.titleKey = itemUseCaseModel.titleKey
        self.companyKey = itemUseCaseModel.companyKey
        self.companyLogoUrl = itemUseCaseModel.companyLogoUrl
        self.locationKey = itemUseCaseModel.locationKey
        self.startDate = itemUseCaseModel.startDate
        self.endDate = itemUseCaseModel.endDate
    }
}
