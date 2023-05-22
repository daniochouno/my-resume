//
//  WorksRepositoryFetchTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import XCTest
@testable import myResume

final class WorksRepositoryFetchTests: XCTestCase {
    var remoteDataSource: MockFirestoreDataSource?
    var cacheDataSource: MockLocalCacheDataSource?
    var settingsBundleDataSource: MockSettingsBundleDataSource?
    var sessionDataSource: MockSessionDataSource?
    
    var repository: WorksRepository?
    let expectation = XCTestExpectation(description: "Repository expectation")
    
    override func setUpWithError() throws {
        self.remoteDataSource = MockFirestoreDataSource()
        self.cacheDataSource = MockLocalCacheDataSource()
        self.settingsBundleDataSource = MockSettingsBundleDataSource()
        self.sessionDataSource = MockSessionDataSource()
        
        self.repository = WorksRepositoryImpl(remoteDataSource: self.remoteDataSource!, cacheDataSource: self.cacheDataSource!, settingsBundleDataSource: self.settingsBundleDataSource!, sessionDataSource: self.sessionDataSource!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let timestampField = FieldTimestampFirestoreModel(timestampValue: "2023-04-28T00:00:00.000Z")
        let fields = WorkFieldFirestoreModel(company: stringField, companyLogoUrl: stringField, titleKey: stringField, location: stringField, startDate: timestampField, endDate: timestampField)
        let workFirestoreModel = WorkFirestoreModel(name: "abc123", fields: fields)
        let arrayWorks = [workFirestoreModel, workFirestoreModel]
        let documents = WorkDocumentsFirestoreModel(documents: arrayWorks)
        self.remoteDataSource?.fetchWorksResult = .success(documents)
        
        let result = await self.repository?.fetch()
        switch result {
        case .success(let repositoryModel):
            XCTAssertEqual(repositoryModel.items.count, arrayWorks.count)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
