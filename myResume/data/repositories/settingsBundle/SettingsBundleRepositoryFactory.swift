//
//  SettingsBundleRepositoryFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

enum SettingsBundleRepositoryFactory {
    static func make() -> SettingsBundleRepository {
        let settingsBundleDataSource = SettingsBundleDataSourceFactory.make()
        let cacheDataSource = LocalCacheDataSourceFactory.make()
        return SettingsBundleRepositoryImpl(settingsBundleDataSource: settingsBundleDataSource, cacheDataSource: cacheDataSource)
    }
}
