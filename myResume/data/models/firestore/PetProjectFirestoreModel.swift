//
//  PetProjectFirestoreModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

struct PetProjectDocumentsFirestoreModel: Decodable {
    let documents: [PetProjectFirestoreModel]
}

struct PetProjectFirestoreModel: Decodable {
    let name: String
    let fields: PetProjectFieldFirestoreModel
}

struct PetProjectFieldFirestoreModel: Decodable {
    let titleKey: PetProjectFieldStringValueFirestoreModel
    let subtitleKey: PetProjectFieldStringValueFirestoreModel
    let iconUrl: PetProjectFieldStringValueFirestoreModel
    let headerColor: PetProjectFieldStringValueFirestoreModel
    let linkAppStore: PetProjectFieldStringValueFirestoreModel?
    let linkPlayStore: PetProjectFieldStringValueFirestoreModel?
    let linkWeb: PetProjectFieldStringValueFirestoreModel?
    let downloads: PetProjectFieldStringValueFirestoreModel?
}

struct PetProjectFieldStringValueFirestoreModel: Decodable {
    let stringValue: String
}
