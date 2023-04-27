//
//  FirestoreDataSourceFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

enum FirestoreDataSourceFactory {
    static func make() -> FirestoreDataSource {
        let apiClient = APIClientFactory.make()
        return FirestoreDataSource(apiClient: apiClient)
    }
}
