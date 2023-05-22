//
//  WorkDetailsUseCaseModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

struct WorkDetailsUseCaseModel: Decodable {
    let type: RepositoryDataSourceTypeModel
    let item: WorkDetailsItemUseCaseModel
}

struct WorkDetailsItemUseCaseModel: Decodable {
    let company: String
    let companyLogoUrl: String
    let title: String
    let location: String
    let startDate: Date
    let endDate: Date?
    let summary: String?
    let goalsAchieved: [String]?
}

extension WorkDetailsItemUseCaseModel {
    init(from firestoreModel: WorkDetailsFirestoreModel) {
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
        if let summaryString = firestoreModel.fields.summaryKey?.stringValue {
            self.summary = summaryString
        } else {
            self.summary = nil
        }
        if let array = firestoreModel.fields.goalsAchievedKeys?.arrayValue {
            self.goalsAchieved = array.values.map({ $0.stringValue })
        } else {
            self.goalsAchieved = nil
        }
    }
}
