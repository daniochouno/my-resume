//
//  FirestoreDataSourceSignInTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import XCTest
@testable import myResume

final class FirestoreDataSourceSignInTests: XCTestCase {
    var dataSource: FirestoreDataSource?
    let expectation = XCTestExpectation(description: "Firestore expectation")

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        let apiClient = APIClient(urlSession: urlSession)
        self.dataSource = FirestoreDataSource(apiClient: apiClient)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() throws {
        let idToken = "abcdef1234"
        let refreshToken = "zyx123"
        let expiresIn = 3600
        let jsonString = """
        {
        "idToken": "\(idToken)",
        "refreshToken": "\(refreshToken)",
        "expiresIn": \(expiresIn)
        }
        """
        let data = jsonString.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw APIResponseError.request
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        }
        
        self.dataSource?.signIn(completion: { result in
            switch result {
            case .success(let session):
                XCTAssertEqual(session.idToken, idToken)
                XCTAssertEqual(session.refreshToken, refreshToken)
                XCTAssertEqual(session.expiresIn, expiresIn)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
    }

    func testFailureParser() {
        let data = Data()
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw APIResponseError.request
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        }
        
        self.dataSource?.signIn(completion: { result in
            switch result {
            case .success:
                XCTFail("Unexpected success response")
            case .failure(let error):
                guard let error = error as? APIResponseError else {
                    XCTFail("Unexpected error received")
                    self.expectation.fulfill()
                    return
                }
                
                XCTAssertEqual(error, APIResponseError.parser, "Parser error was expected")
            }
            
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
    }
}
