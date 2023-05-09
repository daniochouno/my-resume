//
//  PetProjectsLocalCacheModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

struct PetProjectsLocalCacheModel: Encodable, Decodable {
    let createdAt: Double
    let documents: PetProjectDocumentsFirestoreModel
}
