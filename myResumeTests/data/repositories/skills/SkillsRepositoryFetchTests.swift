//
//  SkillsRepositoryFetchTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import XCTest
@testable import myResume

final class SkillsRepositoryFetchTests: XCTestCase {
    var dataSource: MockJsonDataSource?
    
    var repository: SkillsRepository?
    let expectation = XCTestExpectation(description: "Repository expectation")
    
    override func setUpWithError() throws {
        self.dataSource = MockJsonDataSource()
        
        self.repository = SkillsRepositoryImpl(dataSource: self.dataSource!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let sectionModel = SkillSectionJsonModel(title: "abc", order: 0, items: [])
        let arraySections = [sectionModel, sectionModel]
        self.dataSource?.fetchSkillsResult = .success(arraySections)
        
        let result = await self.repository?.fetch()
        switch result {
        case .success(let works):
            XCTAssertEqual(works.count, arraySections.count)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
