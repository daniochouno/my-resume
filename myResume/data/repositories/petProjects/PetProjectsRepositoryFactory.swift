//
//  PetProjectsRepositoryFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

enum PetProjectsRepositoryFactory {
    static func make() -> PetProjectsRepository {
        let remoteDataSource = FirestoreDataSourceFactory.make()
        let cacheDataSource = LocalCacheDataSourceFactory.make()
        let userDefaults = UserDefaults.standard
        return PetProjectsRepositoryImpl(remoteDataSource: remoteDataSource, cacheDataSource: cacheDataSource, userDefaults: userDefaults)
    }
}
