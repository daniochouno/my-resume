//
//  FetchSkillSectionsUseCaseTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import XCTest
@testable import myResume

final class FetchSkillSectionsUseCaseTests: XCTestCase {
    var repository: MockSkillsRepository?
    
    var useCase: FetchSkillSectionsUseCase?
    let expectation = XCTestExpectation(description: "UseCase expectation")
    
    override func setUpWithError() throws {
        self.repository = MockSkillsRepository()
        
        self.useCase = FetchSkillSectionsUseCaseImpl(repository: self.repository!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let sectionModel = SkillSectionJsonModel(title: "abc", order: 0, items: [])
        let arraySections = [sectionModel, sectionModel]
        self.repository?.fetchResult = .success(arraySections)
        
        let result = await self.useCase?.fetch()
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
