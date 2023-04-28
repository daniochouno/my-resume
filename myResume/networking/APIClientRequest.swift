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
    let needsAuthentication: Bool
    let body: Data?
}

extension APIClientRequest {
    init(url: String, method: APIClientRequestMethod) {
        self.url = url
        self.method = method
        self.needsAuthentication = true
        self.body = nil
    }
}

enum APIClientRequestMethod: String {
    case GET
    case POST
}
