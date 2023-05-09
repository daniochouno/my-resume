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
    var fetchPetProjectsResult: Result<PetProjectsLocalCacheModel, Error>?
    
    func fetchWorks() -> Result<WorksLocalCacheModel, Error> {
        guard let result = self.fetchWorksResult else {
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
    
    func storeWorks(documents: myResume.WorkDocumentsFirestoreModel) -> Bool {
        return true
    }
    
    func storePetProjects(documents: myResume.PetProjectDocumentsFirestoreModel) -> Bool {
        return true
    }
}
