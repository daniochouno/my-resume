//
//  PetProjectsRepositoryFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

enum PetProjectsRepositoryFactory {
    static func make() -> PetProjectsRepository {
        let dataSource = FirestoreDataSourceFactory.make()
        let userDefaults = UserDefaults.standard
        return PetProjectsRepositoryImpl(dataSource: dataSource, userDefaults: userDefaults)
    }
}
