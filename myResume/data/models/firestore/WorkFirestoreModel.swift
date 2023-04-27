//
//  WorkFirestoreModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

struct WorkDocumentsFirestoreModel: Decodable {
    let documents: [WorkFirestoreModel]
}

struct WorkFirestoreModel: Decodable {
    let name: String
    let fields: WorkFieldFirestoreModel
}

struct WorkFieldFirestoreModel: Decodable {
    let company: WorkFieldStringValueFirestoreModel
    let title: WorkFieldStringValueFirestoreModel
    let location: WorkFieldStringValueFirestoreModel
    let startDate: WorkFieldTimestampValueFirestoreModel
    let endDate: WorkFieldTimestampValueFirestoreModel?
}

struct WorkFieldStringValueFirestoreModel: Decodable {
    let stringValue: String
}

struct WorkFieldTimestampValueFirestoreModel: Decodable {
    let timestampValue: String
}
