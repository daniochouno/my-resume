//
//  MockLocalCacheDataSource.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation
@testable import myResume

class MockLocalCacheDataSource: LocalCacheDataSource {
    var fetchWorksResult: Result<WorksLocalCacheModel, Error>?
    var fetchWorkDetailsResult: Result<WorkDetailsLocalCacheModel, Error>?
    var fetchPetProjectsResult: Result<PetProjectsLocalCacheModel, Error>?
    
    func fetchWorks() -> Result<WorksLocalCacheModel, Error> {
        guard let result = self.fetchWorksResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
    
    func fetchWorkDetails(id: String) -> Result<WorkDetailsLocalCacheModel, Error> {
        guard let result = self.fetchWorkDetailsResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
    
    func fetchPetProjects() -> Result<PetProjectsLocalCacheModel, Error> {
        guard let result = self.fetchPetProjectsResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
    
    func storeWorks(documents: WorkDocumentsFirestoreModel) -> Bool {
        return true
    }
    
    func storeWorkDetails(id: String, item: WorkDetailsFirestoreModel) -> Bool {
        return true
    }
    
    func storePetProjects(documents: PetProjectDocumentsFirestoreModel) -> Bool {
        return true
    }
    
    func removeWorks() {
        
    }
    
    func removeWorkDetails() {
        
    }
    
    func removePetProjects() {
        
    }
}
