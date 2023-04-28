//
//  WorksRepositoryFetchTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import XCTest
@testable import myResume

final class WorksRepositoryFetchTests: XCTestCase {
    var dataSource: MockFirestoreDataSource?
    var userDefaults: MockUserDefaults?
    
    var repository: WorksRepository?
    let expectation = XCTestExpectation(description: "Repository expectation")
    
    override func setUpWithError() throws {
        self.dataSource = MockFirestoreDataSource()
        self.userDefaults = MockUserDefaults()
        
        self.repository = WorksRepositoryImpl(dataSource: self.dataSource!, userDefaults: self.userDefaults!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let stringField = WorkFieldStringValueFirestoreModel(stringValue: "abc")
        let timestampField = WorkFieldTimestampValueFirestoreModel(timestampValue: "def")
        let fields = WorkFieldFirestoreModel(company: stringField, title: stringField, location: stringField, startDate: timestampField, endDate: timestampField)
        let workFirestoreModel = WorkFirestoreModel(name: "abc123", fields: fields)
        let arrayWorks = [workFirestoreModel, workFirestoreModel]
        let documents = WorkDocumentsFirestoreModel(documents: arrayWorks)
        self.dataSource?.fetchWorksResult = .success(documents)
        
        let result = await self.repository?.fetch()
        switch result {
        case .success(let works):
            XCTAssertEqual(works.count, arrayWorks.count)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
