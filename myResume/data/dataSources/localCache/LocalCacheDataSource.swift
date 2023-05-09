//
//  LocalCacheDataSource.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

protocol LocalCacheDataSource {
    func fetchWorks() -> Result<WorksLocalCacheModel, Error>
    func fetchPetProjects() -> Result<PetProjectsLocalCacheModel, Error>
    func storeWorks(documents: WorkDocumentsFirestoreModel) -> Bool
    func storePetProjects(documents: PetProjectDocumentsFirestoreModel) -> Bool
}

class LocalCacheDataSourceImpl: LocalCacheDataSource {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func fetchWorks() -> Result<WorksLocalCacheModel, Error> {
        guard let data = self.userDefaults.data(forKey: "works") else {
            return .failure(APIResponseError.parser)
        }
        do {
            let localCacheModel: WorksLocalCacheModel = try JSONDecoder().decode(WorksLocalCacheModel.self, from: data)
            return .success(localCacheModel)
        } catch {
            return .failure(APIResponseError.parser)
        }
    }
    
    func fetchPetProjects() -> Result<PetProjectsLocalCacheModel, Error> {
        guard let data = self.userDefaults.data(forKey: "petProjects") else {
            return .failure(APIResponseError.parser)
        }
        do {
            let localCacheModel: PetProjectsLocalCacheModel = try JSONDecoder().decode(PetProjectsLocalCacheModel.self, from: data)
            return .success(localCacheModel)
        } catch {
            return .failure(APIResponseError.parser)
        }
    }
    
    func storeWorks(documents: WorkDocumentsFirestoreModel) -> Bool {
        let now = Date().timeIntervalSince1970
        let localCacheModel = WorksLocalCacheModel(createdAt: now, documents: documents)
        
        do {
            let data = try JSONEncoder().encode(localCacheModel)
            
            self.userDefaults.set(data, forKey: "works")
            return true
        } catch {
            return false
        }
    }
    
    func storePetProjects(documents: PetProjectDocumentsFirestoreModel) -> Bool {
        let now = Date().timeIntervalSince1970
        let localCacheModel = PetProjectsLocalCacheModel(createdAt: now, documents: documents)
        
        do {
            let data = try JSONEncoder().encode(localCacheModel)
            
            self.userDefaults.set(data, forKey: "petProjects")
            return true
        } catch {
            return false
        }
    }
}
