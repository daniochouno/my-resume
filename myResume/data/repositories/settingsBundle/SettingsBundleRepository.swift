//
//  SettingsBundleRepository.swift
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

protocol SettingsBundleRepository {
    func clearLocalCacheIfNeeded()
    func setVersionApp()
}

class SettingsBundleRepositoryImpl: SettingsBundleRepository {
    let cacheDataSource: LocalCacheDataSource
    let userDefaults: UserDefaults
    
    init(cacheDataSource: LocalCacheDataSource, userDefaults: UserDefaults) {
        self.cacheDataSource = cacheDataSource
        self.userDefaults = userDefaults
    }
    
    func clearLocalCacheIfNeeded() {
        let localCacheClear = userDefaults.bool(forKey: SettingsBundleKey.localCacheClear.rawValue)
        guard localCacheClear else { return }
        
        userDefaults.set(false, forKey: SettingsBundleKey.localCacheClear.rawValue)
        cacheDataSource.removeWorks()
        cacheDataSource.removePetProjects()
    }
    
    func setVersionApp() {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return
        }
        guard let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return
        }
        userDefaults.set("\(version) b\(build)", forKey: SettingsBundleKey.appVersion.rawValue)
    }
}
