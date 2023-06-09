//
//  RepositoryDataSourceTypeModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

enum RepositoryDataSourceTypeModel: String, Encodable, Decodable {
    case localCache
    case remote
}
