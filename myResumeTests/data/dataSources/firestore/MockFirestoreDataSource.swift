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
    var fetchWorkDetailsResult: Result<WorkDetailsFirestoreModel, Error>?
    var fetchPetProjectsResult: Result<PetProjectDocumentsFirestoreModel, Error>?
    var fetchPetProjectDetailsResult: Result<PetProjectDetailsFirestoreModel, Error>?
    
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
    
    func fetchWorkDetails(id: String) async -> Result<WorkDetailsFirestoreModel, Error> {
        guard let result = self.fetchWorkDetailsResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
    
    func fetchPetProjects() async -> Result<PetProjectDocumentsFirestoreModel, Error> {
        guard let result = self.fetchPetProjectsResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
    
    func fetchPetProjectDetails(id: String) async -> Result<PetProjectDetailsFirestoreModel, Error> {
        guard let result = self.fetchPetProjectDetailsResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}
