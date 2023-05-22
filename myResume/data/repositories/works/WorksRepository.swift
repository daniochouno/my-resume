//
//  WorksRepository.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

protocol WorksRepository {
    func fetch() async -> Result<WorkRepositoryModel, Error>
    func fetchDetails(id: String) async -> Result<WorkDetailsRepositoryModel, Error>
}

class WorksRepositoryImpl: WorksRepository {
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
    
    func fetch() async -> Result<WorkRepositoryModel, Error> {
        if let cacheResult = cacheFetch() {
            let repositoryModel = WorkRepositoryModel(type: .localCache, items: cacheResult)
            return .success(repositoryModel)
        }
        
        let remoteResult = await remoteFetch()
        switch remoteResult {
        case .success(let items):
            let workDocumentsFirestoreModel = WorkDocumentsFirestoreModel(documents: items)
            _ = self.cacheDataSource.storeWorks(documents: workDocumentsFirestoreModel)
            
            let repositoryModel = WorkRepositoryModel(type: .remote, items: items)
            return .success(repositoryModel)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func cacheFetch() -> [WorkFirestoreModel]? {
        let cacheResult = cacheDataSource.fetchWorks()
        switch cacheResult {
        case .success(let model):
            let expirationTimeInSeconds = settingsBundleDataSource.fetchLocalCacheExpirationTimeValue()
            
            let now = Date().timeIntervalSince1970
            let cacheStoredAt = model.createdAt
            guard ((cacheStoredAt + expirationTimeInSeconds) >= now) else {
                // Expired cache
                return nil
            }
            
            let works = model.documents.documents
            return works
        case .failure:
            return nil
        }
    }
    
    private func remoteFetch() async -> Result<[WorkFirestoreModel], Error> {
        await authenticateIfNeeded()
        
        let result = await remoteDataSource.fetchWorks()
        switch result {
        case .success(let documents):
            let works = documents.documents
            return .success(works)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchDetails(id: String) async -> Result<WorkDetailsRepositoryModel, Error> {
        if let cacheResult = cacheFetchDetails(id: id) {
            let repositoryModel = WorkDetailsRepositoryModel(type: .localCache, item: cacheResult)
            return .success(repositoryModel)
        }
        
        let remoteResult = await remoteFetchDetails(id: id)
        switch remoteResult {
        case .success(let item):
            _ = self.cacheDataSource.storeWorkDetails(id: id, item: item)
            
            let repositoryModel = WorkDetailsRepositoryModel(type: .remote, item: item)
            return .success(repositoryModel)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func cacheFetchDetails(id: String) -> WorkDetailsFirestoreModel? {
        let cacheResult = cacheDataSource.fetchWorkDetails(id: id)
        switch cacheResult {
        case .success(let model):
            let expirationTimeInSeconds = settingsBundleDataSource.fetchLocalCacheExpirationTimeValue()
            
            let now = Date().timeIntervalSince1970
            let cacheStoredAt = model.createdAt
            guard ((cacheStoredAt + expirationTimeInSeconds) >= now) else {
                // Expired cache
                return nil
            }
            
            let workDetails = model.item
            return workDetails
        case .failure:
            return nil
        }
    }
    
    private func remoteFetchDetails(id: String) async -> Result<WorkDetailsFirestoreModel, Error> {
        await authenticateIfNeeded()
        
        let result = await remoteDataSource.fetchWorkDetails(id: id)
        switch result {
        case .success(let details):
            return .success(details)
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
