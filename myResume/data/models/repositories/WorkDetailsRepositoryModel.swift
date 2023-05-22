//
//  WorkDetailsRepositoryModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

struct WorkDetailsRepositoryModel: Encodable, Decodable {
    let type: RepositoryDataSourceTypeModel
    let item: WorkDetailsFirestoreModel
}
