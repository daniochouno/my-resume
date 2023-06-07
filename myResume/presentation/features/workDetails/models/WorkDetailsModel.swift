//
//  WorkDetailsModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

struct WorkDetailsModel: Identifiable, Equatable {
    let id: UUID
    let titleKey: String
    let companyKey: String
    let companyLogoUrl: String
    let locationKey: String
    let startDate: Date
    let endDate: Date?
    let summaryKey: String?
    let goalsAchieved: [String]?
}

extension WorkDetailsModel {
    init(from itemUseCaseModel: WorkDetailsItemUseCaseModel) {
        self.id = UUID()
        self.titleKey = itemUseCaseModel.titleKey
        self.companyKey = itemUseCaseModel.companyKey
        self.companyLogoUrl = itemUseCaseModel.companyLogoUrl
        self.locationKey = itemUseCaseModel.locationKey
        self.startDate = itemUseCaseModel.startDate
        self.endDate = itemUseCaseModel.endDate
        self.summaryKey = itemUseCaseModel.summaryKey
        self.goalsAchieved = itemUseCaseModel.goalsAchieved
    }
}
