//
//  FirestoreDataSourceFetchWorkDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import XCTest
@testable import myResume

final class FirestoreDataSourceFetchWorkDetailsTests: XCTestCase {
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
            "name": "projects/my-resume-4ee9b/databases/(default)/documents/works/axv0BMVwVnZha787kP0j",
            "fields": {
                "startDate": {
                    "timestampValue": "2017-01-08T23:00:00.470Z"
                },
                "endDate": {
                    "timestampValue": "2020-03-01T23:00:00.103Z"
                },
                "companyLogoUrl": {
                    "stringValue": "https://media.licdn.com/dms/image/C4D0BAQGVa-uRHWyW9Q/company-logo_200_200/0/1592928965288?e=1692230400&v=beta&t=idYVa6GKP4Eoe_f0iiAfCocQeAm7LR5HNA4iS3bZrSw"
                },
                "goalsAchievedKeys": {
                    "arrayValue": {
                        "values": [
                            {
                                "stringValue": "works.infinia.ios.goalsAchieved.0"
                            },
                            {
                                "stringValue": "works.infinia.ios.goalsAchieved.1"
                            },
                            {
                                "stringValue": "works.infinia.ios.goalsAchieved.2"
                            }
                        ]
                    }
                },
                "titleKey": {
                    "stringValue": "works.infinia.ios.title"
                },
                "company": {
                    "stringValue": "Infinia Mobile"
                },
                "summaryKey": {
                    "stringValue": "works.infinia.ios.summary"
                },
                "location": {
                    "stringValue": "Madrid, Comunidad de Madrid, España"
                }
            },
            "createTime": "2023-04-24T18:49:28.080805Z",
            "updateTime": "2023-05-18T18:58:59.974505Z"
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
        
        let documentId = "axv0BMVwVnZha787kP0j"
        let result = await self.dataSource?.fetchWorkDetails(id: documentId)
        switch result {
        case .success(let details):
            let goalsAchieved = details.fields.goalsAchievedKeys?.arrayValue.values ?? []
            XCTAssertEqual(goalsAchieved.count, 3, "Found \(goalsAchieved.count) expected works")
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
        
        let documentId = "axv0BMVwVnZha787kP0j"
        let result = await self.dataSource?.fetchWorkDetails(id: documentId)
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
