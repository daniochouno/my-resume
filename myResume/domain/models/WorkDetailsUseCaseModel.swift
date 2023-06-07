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
    let companyKey: String
    let companyLogoUrl: String
    let titleKey: String
    let locationKey: String
    let startDate: Date
    let endDate: Date?
    let summaryKey: String?
    let goalsAchieved: [String]?
}

extension WorkDetailsItemUseCaseModel {
    init(from firestoreModel: WorkDetailsFirestoreModel) {
        self.companyKey = firestoreModel.fields.companyKey.stringValue
        self.companyLogoUrl = firestoreModel.fields.companyLogoUrl.stringValue
        self.titleKey = firestoreModel.fields.titleKey.stringValue
        self.locationKey = firestoreModel.fields.locationKey.stringValue
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
            self.summaryKey = summaryString
        } else {
            self.summaryKey = nil
        }
        if let array = firestoreModel.fields.goalsAchievedKeys?.arrayValue {
            self.goalsAchieved = array.values.map({ $0.stringValue })
        } else {
            self.goalsAchieved = nil
        }
    }
}
