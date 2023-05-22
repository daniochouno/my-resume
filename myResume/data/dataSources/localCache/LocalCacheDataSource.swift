//
//  LocalCacheDataSource.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

enum LocalCacheKey: String {
    case cacheWorks
    case cacheWorkDetails
    case cachePetProjects
    case cachePetProjectDetails
}

protocol LocalCacheDataSource {
    func fetchWorks() -> Result<WorksLocalCacheModel, Error>
    func fetchWorkDetails(id: String) -> Result<WorkDetailsLocalCacheModel, Error>
    func fetchPetProjects() -> Result<PetProjectsLocalCacheModel, Error>
    func fetchPetProjectDetails(id: String) -> Result<PetProjectDetailsLocalCacheModel, Error>
    func storeWorks(documents: WorkDocumentsFirestoreModel) -> Bool
    func storeWorkDetails(id: String, item: WorkDetailsFirestoreModel) -> Bool
    func storePetProjects(documents: PetProjectDocumentsFirestoreModel) -> Bool
    func storePetProjectDetails(id: String, item: PetProjectDetailsFirestoreModel) -> Bool
    func removeWorks()
    func removeWorkDetails()
    func removePetProjects()
    func removePetProjectDetails()
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
    
    func fetchWorkDetails(id: String) -> Result<WorkDetailsLocalCacheModel, Error> {
        let key = LocalCacheKey.cacheWorkDetails.rawValue + "." + id
        guard let data = self.userDefaults.data(forKey: key) else {
            return .failure(APIResponseError.parser)
        }
        do {
            let localCacheModel: WorkDetailsLocalCacheModel = try JSONDecoder().decode(WorkDetailsLocalCacheModel.self, from: data)
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
    
    func fetchPetProjectDetails(id: String) -> Result<PetProjectDetailsLocalCacheModel, Error> {
        let key = LocalCacheKey.cachePetProjectDetails.rawValue + "." + id
        guard let data = self.userDefaults.data(forKey: key) else {
            return .failure(APIResponseError.parser)
        }
        do {
            let localCacheModel: PetProjectDetailsLocalCacheModel = try JSONDecoder().decode(PetProjectDetailsLocalCacheModel.self, from: data)
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
    
    func storeWorkDetails(id: String, item: WorkDetailsFirestoreModel) -> Bool {
        let key = LocalCacheKey.cacheWorkDetails.rawValue + "." + id
        let now = Date().timeIntervalSince1970
        let localCacheModel = WorkDetailsLocalCacheModel(createdAt: now, item: item)
        
        do {
            let data = try JSONEncoder().encode(localCacheModel)
            
            self.userDefaults.set(data, forKey: key)
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
    
    func storePetProjectDetails(id: String, item: PetProjectDetailsFirestoreModel) -> Bool {
        let key = LocalCacheKey.cachePetProjectDetails.rawValue + "." + id
        let now = Date().timeIntervalSince1970
        let localCacheModel = PetProjectDetailsLocalCacheModel(createdAt: now, item: item)
        
        do {
            let data = try JSONEncoder().encode(localCacheModel)
            
            self.userDefaults.set(data, forKey: key)
            return true
        } catch {
            return false
        }
    }
    
    func removeWorks() {
        self.userDefaults.removeObject(forKey: LocalCacheKey.cacheWorks.rawValue)
    }
    
    func removeWorkDetails() {
        let allData = self.userDefaults.dictionaryRepresentation()
        let prefix = LocalCacheKey.cacheWorkDetails.rawValue + "."
        let keys = allData.keys.filter { $0.hasPrefix(prefix) }
        for key in keys {
            self.userDefaults.removeObject(forKey: key)
        }
    }
    
    func removePetProjects() {
        self.userDefaults.removeObject(forKey: LocalCacheKey.cachePetProjects.rawValue)
    }
    
    func removePetProjectDetails() {
        let allData = self.userDefaults.dictionaryRepresentation()
        let prefix = LocalCacheKey.cachePetProjectDetails.rawValue + "."
        let keys = allData.keys.filter { $0.hasPrefix(prefix) }
        for key in keys {
            self.userDefaults.removeObject(forKey: key)
        }
    }
}
