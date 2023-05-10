//
//  SessionDataSourceFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

enum SessionDataSourceFactory {
    static func make() -> SessionDataSource {
        let userDefaults = UserDefaults.standard
        return SessionDataSourceImpl(userDefaults: userDefaults)
    }
}
