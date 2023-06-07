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
    let companyKey: FieldStringFirestoreModel
    let companyLogoUrl: FieldStringFirestoreModel
    let titleKey: FieldStringFirestoreModel
    let locationKey: FieldStringFirestoreModel
    let startDate: FieldTimestampFirestoreModel
    let endDate: FieldTimestampFirestoreModel?
}
