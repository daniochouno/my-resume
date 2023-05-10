//
//  MockSettingsBundleDataSource.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation
@testable import myResume

class MockSettingsBundleDataSource: SettingsBundleDataSource {
    var fetchLocalCacheExpirationTimeValueResult: Int?
    var fetchLocalCacheClearValueResult: Bool?
    
    func fetchLocalCacheExpirationTimeValue() -> Int {
        guard let result = self.fetchLocalCacheExpirationTimeValueResult else {
            return 0
        }
        return result
    }
    
    func fetchLocalCacheClearValue() -> Bool {
        guard let result = self.fetchLocalCacheClearValueResult else {
            return false
        }
        return result
    }
    
    func disableLocalCacheClearValue() {
        
    }
    
    func storeVersionApp(version: String, build: String) {
        
    }
}
