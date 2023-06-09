//
//  WorksRepositoryFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

enum WorksRepositoryFactory {
    static func make() -> WorksRepository {
        let remoteDataSource = FirestoreDataSourceFactory.make()
        let cacheDataSource = LocalCacheDataSourceFactory.make()
        let settingsBundleDataSource = SettingsBundleDataSourceFactory.make()
        let sessionDataSource = SessionDataSourceFactory.make()
        return WorksRepositoryImpl(remoteDataSource: remoteDataSource, cacheDataSource: cacheDataSource, settingsBundleDataSource: settingsBundleDataSource, sessionDataSource: sessionDataSource)
    }
}
