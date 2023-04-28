//
//  SessionFirestoreModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

struct SessionFirestoreModel: Decodable {
    let idToken: String
    let refreshToken: String
    let expiresIn: String
}
