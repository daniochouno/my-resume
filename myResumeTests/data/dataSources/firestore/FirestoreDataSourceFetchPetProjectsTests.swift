//
//  FirestoreDataSourceFetchPetProjectsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import XCTest
@testable import myResume

final class FirestoreDataSourceFetchPetProjectsTests: XCTestCase {
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
            "name": "petProjectA",
            "fields": {
                "titleKey": {
                    "stringValue": "Project A"
                },
                "subtitleKey": {
                    "stringValue": "Headline A"
                },
                "headerColor": {
                    "stringValue": "#FFFFFF"
                },
                "iconUrl": {
                    "stringValue": "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"
                },
                "linkAppStore": {
                    "stringValue": "https://www.google.com"
                },
                "linkPlayStore": {
                    "stringValue": "https://www.google.com"
                },
                "linkWeb": {
                    "stringValue": "https://www.google.com"
                },
                "downloads": {
                    "integerValue": "10"
                }
            }
        }, {
            "name": "petProjectB",
            "fields": {
                "titleKey": {
                    "stringValue": "Project B"
                },
                "subtitleKey": {
                    "stringValue": "Headline B"
                },
                "headerColor": {
                    "stringValue": "#FFFFFF"
                },
                "iconUrl": {
                    "stringValue": "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"
                },
                "linkAppStore": {
                    "stringValue": "https://www.google.com"
                },
                "linkPlayStore": {
                    "stringValue": "https://www.google.com"
                },
                "linkWeb": {
                    "stringValue": "https://www.google.com"
                },
                "downloads": {
                    "integerValue": "10"
                }
            }
        }, {
            "name": "petProjectC",
            "fields": {
                "titleKey": {
                    "stringValue": "Project C"
                },
                "subtitleKey": {
                    "stringValue": "Headline C"
                },
                "headerColor": {
                    "stringValue": "#FFFFFF"
                },
                "iconUrl": {
                    "stringValue": "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"
                },
                "linkAppStore": {
                    "stringValue": "https://www.google.com"
                },
                "linkPlayStore": {
                    "stringValue": "https://www.google.com"
                },
                "linkWeb": {
                    "stringValue": "https://www.google.com"
                },
                "downloads": {
                    "integerValue": "10"
                }
            }
        }, {
            "name": "petProjectD",
            "fields": {
                "titleKey": {
                    "stringValue": "Project D"
                },
                "subtitleKey": {
                    "stringValue": "Headline D"
                },
                "headerColor": {
                    "stringValue": "#FFFFFF"
                },
                "iconUrl": {
                    "stringValue": "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"
                },
                "linkAppStore": {
                    "stringValue": "https://www.google.com"
                },
                "linkPlayStore": {
                    "stringValue": "https://www.google.com"
                },
                "linkWeb": {
                    "stringValue": "https://www.google.com"
                },
                "downloads": {
                    "integerValue": "10"
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
        
        let result = await self.dataSource?.fetchPetProjects()
        switch result {
        case .success(let documents):
            let petProjects = documents.documents
            XCTAssertEqual(petProjects.count, 4, "Found \(petProjects.count) expected works")
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
        
        let result = await self.dataSource?.fetchPetProjects()
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
