//
//  PetProjectEntity.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

struct PetProjectEntity: Equatable {
    let type: RepositoryDataSourceTypeModel
    let items: [PetProjectItemEntity]
}
