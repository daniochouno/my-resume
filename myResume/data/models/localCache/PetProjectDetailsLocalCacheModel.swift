//
//  PetProjectDetailsLocalCacheModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import Foundation

struct PetProjectDetailsLocalCacheModel: Encodable, Decodable {
    let createdAt: Double
    let item: PetProjectDetailsFirestoreModel
}
