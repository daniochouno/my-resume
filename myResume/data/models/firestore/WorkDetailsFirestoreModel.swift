//
//  WorkDetailsFirestoreModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

struct WorkDetailsFirestoreModel: Encodable, Decodable {
    let name: String
    let fields: WorkDetailsFieldFirestoreModel
}

struct WorkDetailsFieldFirestoreModel: Encodable, Decodable {
    let companyKey: FieldStringFirestoreModel
    let companyLogoUrl: FieldStringFirestoreModel
    let titleKey: FieldStringFirestoreModel
    let locationKey: FieldStringFirestoreModel
    let startDate: FieldTimestampFirestoreModel
    let endDate: FieldTimestampFirestoreModel?
    let summaryKey: FieldStringFirestoreModel?
    let goalsAchievedKeys: FieldArrayFirestoreModel?
}
