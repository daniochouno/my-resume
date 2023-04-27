//
//  MockURLProtocol.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (Data?, URLResponse?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let requestHandler = MockURLProtocol.requestHandler else {
            fatalError("requestHandler is not available")
        }
        
        do {
            let (data, urlResponse, error) = try requestHandler(request)
            
            if let error {
                self.client?.urlProtocol(self, didFailWithError: error)
            }
            
            if let data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            
            if let urlResponse {
                self.client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
            }
            
            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() { }
}
