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
    func fetchLocalCacheExpirationTimeValue() -> Double
    func fetchLocalCacheClearValue() -> Bool
    func disableLocalCacheClearValue()
    func storeVersionApp(version: String, build: String)
    func storeDefaultLocalCacheExpirationTime()
    func storeDefaultLocalCacheClear()
}

class SettingsBundleDataSourceImpl: SettingsBundleDataSource {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func fetchLocalCacheExpirationTimeValue() -> Double {
        let localCacheExpirationTime = userDefaults.double(forKey: SettingsBundleKey.localCacheExpirationTime.rawValue)
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
    
    func storeDefaultLocalCacheExpirationTime() {
        let value: Double = 3600
        userDefaults.set(value, forKey: SettingsBundleKey.localCacheExpirationTime.rawValue)
    }
    
    func storeDefaultLocalCacheClear() {
        userDefaults.set(false, forKey: SettingsBundleKey.localCacheClear.rawValue)
    }
}
