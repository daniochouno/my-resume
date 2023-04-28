//
//  WorkModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

struct WorkUseCaseModel: Decodable {
    let company: String
    let title: String
    let location: String
    let startDate: Date
    let endDate: Date?
}

extension WorkUseCaseModel {
    init(from firestoreModel: WorkFirestoreModel) {
        self.company = firestoreModel.fields.company.stringValue
        self.title = firestoreModel.fields.title.stringValue
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

extension String {
    func parseDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
}
