//
//  MockSessionDataSource.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation
@testable import myResume

class MockSessionDataSource: SessionDataSource {
    var fetchCurrentAccessTokenResult: String?
    var fetchCurrentSessionResult: SessionFirestoreModel?
    
    func fetchCurrentAccessToken() -> String? {
        guard let result = self.fetchCurrentAccessTokenResult else {
            return nil
        }
        return result
    }
    
    func fetchCurrentSession() -> SessionFirestoreModel? {
        guard let result = self.fetchCurrentSessionResult else {
            return nil
        }
        return result
    }
    
    func storeCurrentSession(model: SessionFirestoreModel) {
        
    }
}
