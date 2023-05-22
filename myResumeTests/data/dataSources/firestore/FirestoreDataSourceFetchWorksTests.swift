//
//  FirestoreDataSourceFetchWorksTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import XCTest
@testable import myResume

final class FirestoreDataSourceFetchWorksTests: XCTestCase {
    var dataSource: FirestoreDataSource?
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        let sessionDataSource = MockSessionDataSource()
        
        let apiClient = APIClientImpl(urlSession: urlSession, sessionDataSource: sessionDataSource)
        self.dataSource = FirestoreDataSourceImpl(apiClient: apiClient)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let jsonString = """
        {
        "documents": [{
            "name": "companyA",
            "fields": {
                "company": {
                    "stringValue": "Company A"
                },
                "companyLogoUrl": {
                    "stringValue": "https://www.google.com"
                },
                "titleKey": {
                    "stringValue": "Title A"
                },
                "location": {
                    "stringValue": "Location A"
                },
                "startDate": {
                    "timestampValue": "2017-01-01T00:00:00.000Z"
                },
                "endDate": {
                    "timestampValue": "2020-01-01T00:00:00.000Z"
                }
            }
        }, {
            "name": "companyB",
            "fields": {
                "company": {
                    "stringValue": "Company B"
                },
                "companyLogoUrl": {
                    "stringValue": "https://www.google.com"
                },
                "titleKey": {
                    "stringValue": "Title B"
                },
                "location": {
                    "stringValue": "Location B"
                },
                "startDate": {
                    "timestampValue": "2020-01-01T00:00:00.000Z"
                },
                "endDate": {
                    "timestampValue": "2023-01-01T00:00:00.000Z"
                }
            }
        }, {
            "name": "companyC",
            "fields": {
                "company": {
                    "stringValue": "Company C"
                },
                "companyLogoUrl": {
                    "stringValue": "https://www.google.com"
                },
                "titleKey": {
                    "stringValue": "Title C"
                },
                "location": {
                    "stringValue": "Location C"
                },
                "startDate": {
                    "timestampValue": "2023-01-01T00:00:00.000Z"
                }
            }
        }]
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
        
        let result = await self.dataSource?.fetchWorks()
        switch result {
        case .success(let documents):
            let works = documents.documents
            XCTAssertEqual(works.count, 3, "Found \(works.count) expected works")
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }

    func testFailureParser() async {
        let data = Data()
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw APIResponseError.request
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        }
        
        let result = await self.dataSource?.fetchWorks()
        switch result {
        case .success:
            XCTFail("Unexpected success response")
        case .failure(let error):
            guard let error = error as? APIResponseError else {
                XCTFail("Unexpected error received")
                return
            }
            
            XCTAssertEqual(error, APIResponseError.parser, "Parser error was expected")
        default:
            XCTFail("Unexpected case")
        }
    }
}
