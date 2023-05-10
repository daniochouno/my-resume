//
//  SessionDataSource.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//
import Foundation

enum SessionKey: String {
    case sessionAccessToken
    case sessionRefreshToken
    case sessionExpiresAt
}

protocol SessionDataSource {
    func fetchCurrentAccessToken() -> String?
    func fetchCurrentSession() -> SessionFirestoreModel?
    func storeCurrentSession(model: SessionFirestoreModel)
}

class SessionDataSourceImpl: SessionDataSource {
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func fetchCurrentAccessToken() -> String? {
        let accessToken = userDefaults.string(forKey: SessionKey.sessionAccessToken.rawValue)
        return accessToken
    }
    
    func fetchCurrentSession() -> SessionFirestoreModel? {
        guard let accessToken = userDefaults.string(forKey: SessionKey.sessionAccessToken.rawValue),
              let refreshToken = userDefaults.string(forKey: SessionKey.sessionRefreshToken.rawValue) else {
            return nil
        }
        
        let expiresAt = userDefaults.double(forKey: SessionKey.sessionExpiresAt.rawValue)
        let now = Date().timeIntervalSince1970
        let expiresIn = expiresAt - now
        
        guard expiresIn > 0 else {
            return nil
        }
        
        let model = SessionFirestoreModel(idToken: accessToken, refreshToken: refreshToken, expiresIn: "\(expiresIn)")
        return model
    }
    
    func storeCurrentSession(model: SessionFirestoreModel) {
        let idToken = model.idToken
        let refreshToken = model.refreshToken
        let expiresIn = model.expiresIn
        let expiresAt = Date().addingTimeInterval(Double(expiresIn) ?? 0)
        
        userDefaults.set(idToken, forKey: SessionKey.sessionAccessToken.rawValue)
        userDefaults.set(refreshToken, forKey: SessionKey.sessionRefreshToken.rawValue)
        userDefaults.set(expiresAt.timeIntervalSince1970, forKey: SessionKey.sessionExpiresAt.rawValue)
    }
}
