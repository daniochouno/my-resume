//
//  WorksRepositoryFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

enum WorksRepositoryFactory {
    static func make() -> WorksRepository {
        let dataSource = FirestoreDataSourceFactory.make()
        let userDefaults = UserDefaults.standard
        return WorksRepositoryImpl(dataSource: dataSource, userDefaults: userDefaults)
    }
}
