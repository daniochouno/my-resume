//
//  APIClientFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

enum APIClientFactory {
    static func make() -> APIClient {
        return APIClient(urlSession: URLSession.shared)
    }
}
