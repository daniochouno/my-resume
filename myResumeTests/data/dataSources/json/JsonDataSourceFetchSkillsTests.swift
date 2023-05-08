//
//  JsonDataSourceFetchSkillsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import XCTest
@testable import myResume

final class JsonDataSourceFetchSkillsTests: XCTestCase {
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let jsonString = """
        [{
            "title": "sectionTitleA",
            "order": 0,
            "items": [{
                "title": "titleA1",
                "experienceInYears": 1,
                "iconAsset": "",
                "foregroundColor": "",
                "backgroundColor": ""
            },{
                "title": "titleA2",
                "experienceInYears": 2,
                "iconAsset": "",
                "foregroundColor": "",
                "backgroundColor": ""
            }]
        },{
            "title": "sectionTitleB",
            "order": 1,
            "items": [{
                "title": "titleB1",
                "experienceInYears": 1,
                "iconAsset": "",
                "foregroundColor": "",
                "backgroundColor": ""
            }]
        }]
        """
        guard let data = jsonString.data(using: .utf8) else {
            XCTFail("Json string fails")
            return
        }
        
        let dataSource = JsonDataSourceImpl(data: data)
        
        let result = await dataSource.fetchSkills()
        switch result {
        case .success(let array):
            XCTAssertEqual(array.count, 2, "Found \(array.count) expected skills")
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFailureParser() async {
        let data = Data()
        
        let dataSource = JsonDataSourceImpl(data: data)
        
        let result = await dataSource.fetchSkills()
        switch result {
        case .success:
            XCTFail("Unexpected success response")
        case .failure(let error):
            guard let error = error as? APIResponseError else {
                XCTFail("Unexpected error received")
                return
            }
            
            XCTAssertEqual(error, APIResponseError.parser, "Parser error was expected")
        }
    }
}
