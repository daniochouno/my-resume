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
    let titleKey: FieldStringFirestoreModel
    let subtitleKey: FieldStringFirestoreModel
    let iconUrl: FieldStringFirestoreModel
    let headerColor: FieldStringFirestoreModel
    let linkAppStore: FieldStringFirestoreModel?
    let linkPlayStore: FieldStringFirestoreModel?
    let linkWeb: FieldStringFirestoreModel?
    let downloads: FieldIntegerFirestoreModel?
}
