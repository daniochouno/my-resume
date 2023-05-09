//
//  WorkModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

struct WorkModel: Identifiable, Equatable {
    let id: UUID
    let title: String
    let company: String
    let location: String
    let startDate: Date
    let endDate: Date?
}

extension WorkModel {
    init(from itemUseCaseModel: WorkItemUseCaseModel) {
        self.id = UUID()
        self.title = itemUseCaseModel.title
        self.company = itemUseCaseModel.company
        self.location = itemUseCaseModel.location
        self.startDate = itemUseCaseModel.startDate
        self.endDate = itemUseCaseModel.endDate
    }
}
