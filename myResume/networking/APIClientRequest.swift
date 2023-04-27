//
//  APIClientRequest.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

struct APIClientRequest {
    let url: String
    let method: APIClientRequestMethod
}

enum APIClientRequestMethod: String {
    case GET
    case POST
}
