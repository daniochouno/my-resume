//
//  SettingsBundleRepositoryFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

enum SettingsBundleRepositoryFactory {
    static func make() -> SettingsBundleRepository {
        let cacheDataSource = LocalCacheDataSourceFactory.make()
        let userDefaults = UserDefaults.standard
        return SettingsBundleRepositoryImpl(cacheDataSource: cacheDataSource, userDefaults: userDefaults)
    }
}
