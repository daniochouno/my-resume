//
//  SettingsBundleRepository.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

protocol SettingsBundleRepository {
    func clearLocalCacheIfNeeded()
    func setVersionApp()
}

class SettingsBundleRepositoryImpl: SettingsBundleRepository {
    let settingsBundleDataSource: SettingsBundleDataSource
    let cacheDataSource: LocalCacheDataSource
    
    init(settingsBundleDataSource: SettingsBundleDataSource, cacheDataSource: LocalCacheDataSource) {
        self.settingsBundleDataSource = settingsBundleDataSource
        self.cacheDataSource = cacheDataSource
    }
    
    func clearLocalCacheIfNeeded() {
        let needsClearLocalCache = settingsBundleDataSource.fetchLocalCacheClearValue()
        guard needsClearLocalCache else { return }
        
        settingsBundleDataSource.disableLocalCacheClearValue()
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
        settingsBundleDataSource.storeVersionApp(version: version, build: build)
    }
}
