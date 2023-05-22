//
//  WorksRepositoryFetchDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import XCTest
@testable import myResume

final class WorksRepositoryFetchDetailsTests: XCTestCase {
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
        let documentId = "abc123"
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let timestampField = FieldTimestampFirestoreModel(timestampValue: "2023-04-28T00:00:00.000Z")
        let arrayValues = FieldArrayValueFirestoreModel(values: [stringField, stringField, stringField])
        let arrayField = FieldArrayFirestoreModel(arrayValue: arrayValues)
        let fields = WorkDetailsFieldFirestoreModel(company: stringField, companyLogoUrl: stringField, titleKey: stringField, location: stringField, startDate: timestampField, endDate: timestampField, summaryKey: stringField, goalsAchievedKeys: arrayField)
        let workDetailsFirestoreModel = WorkDetailsFirestoreModel(name: documentId, fields: fields)
        self.remoteDataSource?.fetchWorkDetailsResult = .success(workDetailsFirestoreModel)
        
        let result = await self.repository?.fetchDetails(id: documentId)
        switch result {
        case .success(let repositoryModel):
            let goalsAchieved = repositoryModel.item.fields.goalsAchievedKeys?.arrayValue.values ?? []
            XCTAssertEqual(goalsAchieved.count, arrayValues.values.count)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
