//
//  WorkDetailsModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

struct WorkDetailsModel: Identifiable, Equatable {
    let id: UUID
    let title: String
    let company: String
    let companyLogoUrl: String
    let location: String
    let startDate: Date
    let endDate: Date?
    let summary: String?
    let goalsAchieved: [String]?
}

extension WorkDetailsModel {
    init(from itemUseCaseModel: WorkDetailsItemUseCaseModel) {
        self.id = UUID()
        self.title = itemUseCaseModel.title
        self.company = itemUseCaseModel.company
        self.companyLogoUrl = itemUseCaseModel.companyLogoUrl
        self.location = itemUseCaseModel.location
        self.startDate = itemUseCaseModel.startDate
        self.endDate = itemUseCaseModel.endDate
        self.summary = itemUseCaseModel.summary
        self.goalsAchieved = itemUseCaseModel.goalsAchieved
    }
}
