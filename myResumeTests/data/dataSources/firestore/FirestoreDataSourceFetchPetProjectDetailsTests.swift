//
//  FirestoreDataSourceFetchPetProjectDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import XCTest
@testable import myResume

final class FirestoreDataSourceFetchPetProjectDetailsTests: XCTestCase {
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
            "name": "projects/my-resume-4ee9b/databases/(default)/documents/petProjects/KIt9AehQ9hVTNl66fSvP",
            "fields": {
                "subtitleKey": {
                    "stringValue": "petProjects.foodCalendar.subtitle"
                },
                "linkAppStore": {
                    "stringValue": "petProjects.foodCalendar.link.appStore"
                },
                "headerColor": {
                    "stringValue": "#DAEF82"
                },
                "downloads": {
                    "integerValue": "3000"
                },
                "iconUrl": {
                    "stringValue": "https://is3-ssl.mzstatic.com/image/thumb/Purple122/v4/bb/ea/15/bbea151d-3baf-65cd-085c-a99e13cd34c4/AppIcon-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp"
                },
                "titleKey": {
                    "stringValue": "petProjects.foodCalendar.title"
                },
                "descriptionLargeKey": {
                    "stringValue": "petProjects.foodCalendar.descriptionLarge"
                }
            },
            "createTime": "2023-05-08T10:14:06.889746Z",
            "updateTime": "2023-05-08T12:30:48.336193Z"
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
        
        let documentId = "KIt9AehQ9hVTNl66fSvP"
        let result = await self.dataSource?.fetchPetProjectDetails(id: documentId)
        switch result {
        case .success(let details):
            guard let iDownloads = details.fields.downloads?.integerValue, let downloads = Int(iDownloads) else {
                XCTFail("Unexpected null downloads")
                return
            }
            XCTAssertEqual(downloads, 3000, "Found Pet Project with \(downloads) downloads")
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
        
        let documentId = "KIt9AehQ9hVTNl66fSvP"
        let result = await self.dataSource?.fetchPetProjectDetails(id: documentId)
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
