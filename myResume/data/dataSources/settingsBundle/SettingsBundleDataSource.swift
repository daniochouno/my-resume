//
//  SettingsBundleDataSource.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

enum SettingsBundleKey: String {
    case appVersion
    case localCacheExpirationTime
    case localCacheClear
}

protocol SettingsBundleDataSource {
    func fetchLocalCacheExpirationTimeValue() -> Int
    func fetchLocalCacheClearValue() -> Bool
    func disableLocalCacheClearValue()
    func storeVersionApp(version: String, build: String)
}

class SettingsBundleDataSourceImpl: SettingsBundleDataSource {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func fetchLocalCacheExpirationTimeValue() -> Int {
        let localCacheExpirationTime = userDefaults.integer(forKey: SettingsBundleKey.localCacheExpirationTime.rawValue)
        return localCacheExpirationTime
    }
    
    func fetchLocalCacheClearValue() -> Bool {
        let localCacheClear = userDefaults.bool(forKey: SettingsBundleKey.localCacheClear.rawValue)
        return localCacheClear
    }
    
    func disableLocalCacheClearValue() {
        userDefaults.set(false, forKey: SettingsBundleKey.localCacheClear.rawValue)
    }
    
    func storeVersionApp(version: String, build: String) {
        userDefaults.set("\(version) b\(build)", forKey: SettingsBundleKey.appVersion.rawValue)
    }
}
