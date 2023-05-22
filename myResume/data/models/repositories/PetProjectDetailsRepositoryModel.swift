//
//  PetProjectDetailsRepositoryModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import Foundation

struct PetProjectDetailsRepositoryModel: Encodable, Decodable {
    let type: RepositoryDataSourceTypeModel
    let item: PetProjectDetailsFirestoreModel
}
