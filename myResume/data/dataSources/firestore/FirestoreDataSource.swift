//
//  FirestoreDataSource.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

protocol FirestoreDataSource {
    func signIn() async -> Result<SessionFirestoreModel, Error>
    func fetchWorks() async -> Result<WorkDocumentsFirestoreModel, Error>
    func fetchWorkDetails(id: String) async -> Result<WorkDetailsFirestoreModel, Error>
    func fetchPetProjects() async -> Result<PetProjectDocumentsFirestoreModel, Error>
    func fetchPetProjectDetails(id: String) async -> Result<PetProjectDetailsFirestoreModel, Error>
}

class FirestoreDataSourceImpl: FirestoreDataSource {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func signIn() async -> Result<SessionFirestoreModel, Error> {
        guard let apiKey = Bundle.main.infoDictionary?["FIRESTORE_API_KEY"] as? String else {
            return .failure(APIResponseError.configuration)
        }
        
        let url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=\(apiKey)"
        let bodyJson: [String: Any] = ["returnSecureToken": true]
        let bodyData = try? JSONSerialization.data(withJSONObject: bodyJson)
        let request = APIClientRequest(url: url, method: .POST, needsAuthentication: false, body: bodyData)
        
        let result: Result<SessionFirestoreModel, Error> = await apiClient.fetch(request: request)
        return result
    }
    
    func fetchWorks() async -> Result<WorkDocumentsFirestoreModel, Error> {
        guard let projectName = Bundle.main.infoDictionary?["FIRESTORE_PROJECT_NAME"] as? String else {
            return .failure(APIResponseError.configuration)
        }
        
        let url = "https://firestore.googleapis.com/v1/projects/\(projectName)/databases/(default)/documents/works"
        let request = APIClientRequest(url: url, method: .GET)
        
        let result: Result<WorkDocumentsFirestoreModel, Error> = await apiClient.fetch(request: request)
        return result
    }
    
    func fetchWorkDetails(id: String) async -> Result<WorkDetailsFirestoreModel, Error> {
        guard let projectName = Bundle.main.infoDictionary?["FIRESTORE_PROJECT_NAME"] as? String else {
            return .failure(APIResponseError.configuration)
        }
        
        let url = "https://firestore.googleapis.com/v1/projects/\(projectName)/databases/(default)/documents/works/\(id)"
        let request = APIClientRequest(url: url, method: .GET)
        
        let result: Result<WorkDetailsFirestoreModel, Error> = await apiClient.fetch(request: request)
        return result
    }
    
    func fetchPetProjects() async -> Result<PetProjectDocumentsFirestoreModel, Error> {
        guard let projectName = Bundle.main.infoDictionary?["FIRESTORE_PROJECT_NAME"] as? String else {
            return .failure(APIResponseError.configuration)
        }
        
        let url = "https://firestore.googleapis.com/v1/projects/\(projectName)/databases/(default)/documents/petProjects"
        let request = APIClientRequest(url: url, method: .GET)
        
        let result: Result<PetProjectDocumentsFirestoreModel, Error> = await apiClient.fetch(request: request)
        return result
    }
    
    func fetchPetProjectDetails(id: String) async -> Result<PetProjectDetailsFirestoreModel, Error> {
        guard let projectName = Bundle.main.infoDictionary?["FIRESTORE_PROJECT_NAME"] as? String else {
            return .failure(APIResponseError.configuration)
        }
        
        let url = "https://firestore.googleapis.com/v1/projects/\(projectName)/databases/(default)/documents/petProjects/\(id)"
        let request = APIClientRequest(url: url, method: .GET)
        
        let result: Result<PetProjectDetailsFirestoreModel, Error> = await apiClient.fetch(request: request)
        return result
    }
}
