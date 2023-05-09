//
//  LocalCacheDataSource.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

protocol LocalCacheDataSource {
    func fetchWorks() -> Result<WorkDocumentsFirestoreModel, Error>
    func fetchPetProjects() -> Result<PetProjectDocumentsFirestoreModel, Error>
    func storeWorks(documents: WorkDocumentsFirestoreModel) -> Bool
    func storePetProjects(documents: PetProjectDocumentsFirestoreModel) -> Bool
}

class LocalCacheDataSourceImpl: LocalCacheDataSource {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func fetchWorks() -> Result<WorkDocumentsFirestoreModel, Error> {
        return .failure(APIResponseError.configuration)
    }
    
    func fetchPetProjects() -> Result<PetProjectDocumentsFirestoreModel, Error> {
        return .failure(APIResponseError.configuration)
    }
    
    func storeWorks(documents: WorkDocumentsFirestoreModel) -> Bool {
        return false
    }
    
    func storePetProjects(documents: PetProjectDocumentsFirestoreModel) -> Bool {
        return false
    }
}
