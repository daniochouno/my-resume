//
//  WorkModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

struct WorkUseCaseModel: Decodable {
    let type: RepositoryDataSourceTypeModel
    let items: [WorkItemUseCaseModel]
}

struct WorkItemUseCaseModel: Decodable {
    let documentId: String
    let company: String
    let companyLogoUrl: String
    let title: String
    let location: String
    let startDate: Date
    let endDate: Date?
}

extension WorkItemUseCaseModel {
    init(from firestoreModel: WorkFirestoreModel) {
        let documentIdUrl = URL(string: firestoreModel.name)!
        self.documentId = documentIdUrl.lastPathComponent
        self.company = firestoreModel.fields.company.stringValue
        self.companyLogoUrl = firestoreModel.fields.companyLogoUrl.stringValue
        self.title = firestoreModel.fields.titleKey.stringValue
        self.location = firestoreModel.fields.location.stringValue
        let startDateString = firestoreModel.fields.startDate.timestampValue
        if let startDate = startDateString.parseDate() {
            self.startDate = startDate
        } else {
            fatalError("startDate format is not valid")
        }
        if let endDateString = firestoreModel.fields.endDate?.timestampValue {
            if let endDate = endDateString.parseDate() {
                self.endDate = endDate
            } else {
                fatalError("endDate format is not valid")
            }
        } else {
            self.endDate = nil
        }
    }
}
