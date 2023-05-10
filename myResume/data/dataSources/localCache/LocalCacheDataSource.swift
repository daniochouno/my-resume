//
//  LocalCacheDataSource.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

enum LocalCacheKey: String {
    case cacheWorks
    case cachePetProjects
}

protocol LocalCacheDataSource {
    func fetchWorks() -> Result<WorksLocalCacheModel, Error>
    func fetchPetProjects() -> Result<PetProjectsLocalCacheModel, Error>
    func storeWorks(documents: WorkDocumentsFirestoreModel) -> Bool
    func storePetProjects(documents: PetProjectDocumentsFirestoreModel) -> Bool
    func removeWorks()
    func removePetProjects()
}

class LocalCacheDataSourceImpl: LocalCacheDataSource {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func fetchWorks() -> Result<WorksLocalCacheModel, Error> {
        guard let data = self.userDefaults.data(forKey: LocalCacheKey.cacheWorks.rawValue) else {
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
        guard let data = self.userDefaults.data(forKey: LocalCacheKey.cachePetProjects.rawValue) else {
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
            
            self.userDefaults.set(data, forKey: LocalCacheKey.cacheWorks.rawValue)
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
            
            self.userDefaults.set(data, forKey: LocalCacheKey.cachePetProjects.rawValue)
            return true
        } catch {
            return false
        }
    }
    
    func removeWorks() {
        self.userDefaults.removeObject(forKey: LocalCacheKey.cacheWorks.rawValue)
    }
    
    func removePetProjects() {
        self.userDefaults.removeObject(forKey: LocalCacheKey.cachePetProjects.rawValue)
    }
}
