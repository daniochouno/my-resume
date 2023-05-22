//
//  WorkDetailsLocalCacheModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 17/5/23.
//

import Foundation

struct WorkDetailsLocalCacheModel: Encodable, Decodable {
    let createdAt: Double
    let item: WorkDetailsFirestoreModel
}
