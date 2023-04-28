//
//  WorksRepository.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

protocol WorksRepository {
    func fetch() async -> Result<[WorkFirestoreModel], Error>
}

class WorksRepositoryImpl: WorksRepository {
    let dataSource: FirestoreDataSource
    let userDefaults: UserDefaults
    
    init(dataSource: FirestoreDataSource, userDefaults: UserDefaults) {
        self.dataSource = dataSource
        self.userDefaults = userDefaults
    }
    
    func fetch() async -> Result<[WorkFirestoreModel], Error> {
        await authenticateIfNeeded()
        
        let result = await dataSource.fetchWorks()
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
        let result = await dataSource.signIn()
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
