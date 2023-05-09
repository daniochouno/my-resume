//
//  LocalCacheDataSourceFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

enum LocalCacheDataSourceFactory {
    static func make() -> LocalCacheDataSource {
        let userDefaults = UserDefaults.standard
        return LocalCacheDataSourceImpl(userDefaults: userDefaults)
    }
}
