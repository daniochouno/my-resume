//
//  WorksRepository.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

protocol WorksRepository {
    func fetch() async -> Result<WorkRepositoryModel, Error>
}

class WorksRepositoryImpl: WorksRepository {
    let remoteDataSource: FirestoreDataSource
    let cacheDataSource: LocalCacheDataSource
    let userDefaults: UserDefaults
    
    private let expirationTimeInSeconds: Double = 3600
    
    init(remoteDataSource: FirestoreDataSource, cacheDataSource: LocalCacheDataSource, userDefaults: UserDefaults) {
        self.remoteDataSource = remoteDataSource
        self.cacheDataSource = cacheDataSource
        self.userDefaults = userDefaults
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
            let now = Date().timeIntervalSince1970
            let cacheStoredAt = model.createdAt
            guard ((cacheStoredAt + expirationTimeInSeconds) <= now) else {
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
    
    private func authenticateIfNeeded() async {
        guard let _ = userDefaults.string(forKey: "access_token"),
                let _ = userDefaults.string(forKey: "refresh_token") else {
            await authenticate()
            return
        }
        
        let expiresAt = userDefaults.double(forKey: "expires_at")
        let currentTimestamp = Date().timeIntervalSince1970
        guard expiresAt >= currentTimestamp else {
            await authenticate()
            return
        }
    }
    
    private func authenticate() async {
        let result = await remoteDataSource.signIn()
        switch result {
        case .success(let session):
            let idToken = session.idToken
            let refreshToken = session.refreshToken
            let expiresIn = session.expiresIn
            let expiresAt = Date().addingTimeInterval(Double(expiresIn) ?? 0)
            
            self.userDefaults.set(idToken, forKey: "access_token")
            self.userDefaults.set(refreshToken, forKey: "refresh_token")
            self.userDefaults.set(expiresAt.timeIntervalSince1970, forKey: "expires_at")
        case .failure:
            break
        }
    }
}
