//
//  FirestoreValueModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 17/5/23.
//

import Foundation

struct FieldStringFirestoreModel: Encodable, Decodable {
    let stringValue: String
}

struct FieldIntegerFirestoreModel: Encodable, Decodable {
    let integerValue: String
}

struct FieldTimestampFirestoreModel: Encodable, Decodable {
    let timestampValue: String
}

struct FieldArrayFirestoreModel: Encodable, Decodable {
    let arrayValue: FieldArrayValueFirestoreModel
}

struct FieldArrayValueFirestoreModel: Encodable, Decodable {
    let values: [FieldStringFirestoreModel]
}
