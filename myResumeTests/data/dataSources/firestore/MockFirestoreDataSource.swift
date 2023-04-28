//
//  MockFirestoreDataSource.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 28/4/23.
//

import Foundation
@testable import myResume

class MockFirestoreDataSource: FirestoreDataSource {
    var signInResult: Result<SessionFirestoreModel, Error>?
    var fetchWorksResult: Result<WorkDocumentsFirestoreModel, Error>?
    
    func signIn() async -> Result<SessionFirestoreModel, Error> {
        guard let result = self.signInResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
    
    func fetchWorks() async -> Result<WorkDocumentsFirestoreModel, Error> {
        guard let result = self.fetchWorksResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}
