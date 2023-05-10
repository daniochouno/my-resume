//
//  PetProjectsRepository.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import Foundation

protocol PetProjectsRepository {
    func fetch() async -> Result<PetProjectRepositoryModel, Error>
}

class PetProjectsRepositoryImpl: PetProjectsRepository {
    let remoteDataSource: FirestoreDataSource
    let cacheDataSource: LocalCacheDataSource
    let settingsBundleDataSource: SettingsBundleDataSource
    let sessionDataSource: SessionDataSource
    
    init(remoteDataSource: FirestoreDataSource, cacheDataSource: LocalCacheDataSource, settingsBundleDataSource: SettingsBundleDataSource, sessionDataSource: SessionDataSource) {
        self.remoteDataSource = remoteDataSource
        self.cacheDataSource = cacheDataSource
        self.settingsBundleDataSource = settingsBundleDataSource
        self.sessionDataSource = sessionDataSource
    }
    
    func fetch() async -> Result<PetProjectRepositoryModel, Error> {
        if let cacheResult = cacheFetch() {
            let repositoryModel = PetProjectRepositoryModel(type: .localCache, items: cacheResult)
            return .success(repositoryModel)
        }
        
        let remoteResult = await remoteFetch()
        switch remoteResult {
        case .success(let items):
            let petProjectDocumentsFirestoreModel = PetProjectDocumentsFirestoreModel(documents: items)
            _ = self.cacheDataSource.storePetProjects(documents: petProjectDocumentsFirestoreModel)
            
            let repositoryModel = PetProjectRepositoryModel(type: .remote, items: items)
            return .success(repositoryModel)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func cacheFetch() -> [PetProjectFirestoreModel]? {
        let cacheResult = cacheDataSource.fetchPetProjects()
        switch cacheResult {
        case .success(let model):
            let expirationTimeInSeconds = settingsBundleDataSource.fetchLocalCacheExpirationTimeValue()
            
            let now = Date().timeIntervalSince1970
            let cacheStoredAt = model.createdAt
            guard ((cacheStoredAt + expirationTimeInSeconds) >= now) else {
                // Expired cache
                return nil
            }
            
            let petProjects = model.documents.documents
            return petProjects
        case .failure:
            return nil
        }
    }
    
    func remoteFetch() async -> Result<[PetProjectFirestoreModel], Error> {
        await authenticateIfNeeded()
        
        let result = await remoteDataSource.fetchPetProjects()
        switch result {
        case .success(let documents):
            let petProjects = documents.documents
            return .success(petProjects)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func authenticateIfNeeded() async {
        if let _ = sessionDataSource.fetchCurrentSession() {
            return
        }
        
        await authenticate()
    }
    
    private func authenticate() async {
        let result = await remoteDataSource.signIn()
        switch result {
        case .success(let model):
            sessionDataSource.storeCurrentSession(model: model)
        case .failure:
            break
        }
    }
}
