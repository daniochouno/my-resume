//
//  PetProjectRepositoryModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

struct PetProjectRepositoryModel: Encodable, Decodable {
    let type: RepositoryDataSourceTypeModel
    let items: [PetProjectFirestoreModel]
}
