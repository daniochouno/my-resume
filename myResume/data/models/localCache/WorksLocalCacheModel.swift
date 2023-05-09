//
//  WorksLocalCacheModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

struct WorksLocalCacheModel: Encodable, Decodable {
    let createdAt: Double
    let documents: WorkDocumentsFirestoreModel
}
