//
//  APIClient.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: Decodable>(request: APIClientRequest, completion: @escaping (Result<T, Error>) -> ())
}

class APIClient: APIClientProtocol {
    let urlSession: URLSession
      
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T: Decodable>(request: APIClientRequest, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: request.url) else {
            completion(Result.failure(APIResponseError.url))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        let dataTask = urlSession.dataTask(with:url) { (data, urlResponse, error) in
            // Check if any error occured.
            if let error = error {
                completion(Result.failure(error))
                return
            }

            // Check response code.
            guard let httpResponse = urlResponse as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(Result.failure(APIResponseError.network))
                return
            }
            
            // Parse data
            if let responseData = data, let object = try? JSONDecoder().decode(T.self, from: responseData) {
                completion(Result.success(object))
            } else {
                completion(Result.failure(APIResponseError.parser))
            }
        }
        
        dataTask.resume()
    }
}
