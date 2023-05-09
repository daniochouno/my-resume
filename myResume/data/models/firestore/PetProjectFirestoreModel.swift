//
//  PetProjectFirestoreModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

struct PetProjectDocumentsFirestoreModel: Encodable, Decodable {
    let documents: [PetProjectFirestoreModel]
}

struct PetProjectFirestoreModel: Encodable, Decodable {
    let name: String
    let fields: PetProjectFieldFirestoreModel
}

struct PetProjectFieldFirestoreModel: Encodable, Decodable {
    let titleKey: PetProjectFieldStringValueFirestoreModel
    let subtitleKey: PetProjectFieldStringValueFirestoreModel
    let iconUrl: PetProjectFieldStringValueFirestoreModel
    let headerColor: PetProjectFieldStringValueFirestoreModel
    let linkAppStore: PetProjectFieldStringValueFirestoreModel?
    let linkPlayStore: PetProjectFieldStringValueFirestoreModel?
    let linkWeb: PetProjectFieldStringValueFirestoreModel?
    let downloads: PetProjectFieldIntegerValueFirestoreModel?
}

struct PetProjectFieldStringValueFirestoreModel: Encodable, Decodable {
    let stringValue: String
}

struct PetProjectFieldIntegerValueFirestoreModel: Encodable, Decodable {
    let integerValue: String
}
