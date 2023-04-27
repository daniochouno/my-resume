//
//  FirestoreDataSource.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

class FirestoreDataSource {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func signIn(completion: @escaping (Result<SessionFirestoreModel, Error>) -> ()) {
        guard let apiKey = Bundle.main.infoDictionary?["FIRESTORE_API_KEY"] as? String else {
            completion(.failure(APIResponseError.configuration))
            return
        }
        
        let url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=\(apiKey)"
        let request = APIClientRequest(url: url, method: .POST)
        
        self.apiClient.fetch(request: request) { result in
            completion(result)
        }
    }
}
