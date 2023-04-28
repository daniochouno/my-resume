//
//  APIClientFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

enum APIClientFactory {
    static func make() -> APIClient {
        let urlSession = URLSession.shared
        let userDefaults = UserDefaults.standard
        return APIClientImpl(urlSession: urlSession, userDefaults: userDefaults)
    }
}
