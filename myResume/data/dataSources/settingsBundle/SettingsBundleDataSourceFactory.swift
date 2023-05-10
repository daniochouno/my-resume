//
//  SettingsBundleDataSourceFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

enum SettingsBundleDataSourceFactory {
    static func make() -> SettingsBundleDataSource {
        let userDefaults = UserDefaults.standard
        return SettingsBundleDataSourceImpl(userDefaults: userDefaults)
    }
}
