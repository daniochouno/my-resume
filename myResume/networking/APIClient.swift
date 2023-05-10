//
//  APIClient.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

protocol APIClient {
    func fetch<T: Decodable>(request: APIClientRequest) async -> Result<T, Error>
}

class APIClientImpl: APIClient {
    let urlSession: URLSession
    let sessionDataSource: SessionDataSource
      
    init(urlSession: URLSession, sessionDataSource: SessionDataSource) {
        self.urlSession = urlSession
        self.sessionDataSource = sessionDataSource
    }
    
    func fetch<T: Decodable>(request: APIClientRequest) async -> Result<T, Error> {
        guard let url = URL(string: request.url) else {
            return .failure(APIResponseError.url)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if request.needsAuthentication {
            if let accessToken = sessionDataSource.fetchCurrentAccessToken() {
                urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
        }
        if let httpBody = request.body {
            urlRequest.httpBody = httpBody
        }
        
        do {
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            
            // Check response code.
            guard let httpResponse = urlResponse as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                return .failure(APIResponseError.network)
            }
            
            // Parse data
            if let object = try? JSONDecoder().decode(T.self, from: data) {
                return .success(object)
            } else {
                return .failure(APIResponseError.parser)
            }
        } catch {
            return .failure(APIResponseError.request)
        }
    }
}
