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
        let settingsBundleDataSource = SettingsBundleDataSourceFactory.make()
        let sessionDataSource = SessionDataSourceFactory.make()
        return PetProjectsRepositoryImpl(remoteDataSource: remoteDataSource, cacheDataSource: cacheDataSource, settingsBundleDataSource: settingsBundleDataSource, sessionDataSource: sessionDataSource)
    }
}
