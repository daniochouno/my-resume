//
//  PetProjectDetailsFirestoreModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import Foundation

struct PetProjectDetailsFirestoreModel: Encodable, Decodable {
    let name: String
    let fields: PetProjectDetailsFieldFirestoreModel
}

struct PetProjectDetailsFieldFirestoreModel: Encodable, Decodable {
    let titleKey: FieldStringFirestoreModel
    let subtitleKey: FieldStringFirestoreModel
    let iconUrl: FieldStringFirestoreModel
    let headerColor: FieldStringFirestoreModel
    let downloads: FieldIntegerFirestoreModel?
    let linkAppStore: FieldStringFirestoreModel?
    let linkPlayStore: FieldStringFirestoreModel?
}
