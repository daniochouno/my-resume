//
//  WorkFirestoreModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

struct WorkDocumentsFirestoreModel: Encodable, Decodable {
    let documents: [WorkFirestoreModel]
}

struct WorkFirestoreModel: Encodable, Decodable {
    let name: String
    let fields: WorkFieldFirestoreModel
}

struct WorkFieldFirestoreModel: Encodable, Decodable {
    let company: WorkFieldStringValueFirestoreModel
    let title: WorkFieldStringValueFirestoreModel
    let location: WorkFieldStringValueFirestoreModel
    let startDate: WorkFieldTimestampValueFirestoreModel
    let endDate: WorkFieldTimestampValueFirestoreModel?
}

struct WorkFieldStringValueFirestoreModel: Encodable, Decodable {
    let stringValue: String
}

struct WorkFieldTimestampValueFirestoreModel: Encodable, Decodable {
    let timestampValue: String
}
