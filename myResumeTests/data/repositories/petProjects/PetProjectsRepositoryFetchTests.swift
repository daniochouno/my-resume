//
//  PetProjectsRepositoryFetchTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import XCTest
@testable import myResume

final class PetProjectsRepositoryFetchTests: XCTestCase {
    var remoteDataSource: MockFirestoreDataSource?
    var cacheDataSource: MockLocalCacheDataSource?
    var settingsBundleDataSource: MockSettingsBundleDataSource?
    var userDefaults: MockUserDefaults?
    
    var repository: PetProjectsRepository?
    let expectation = XCTestExpectation(description: "Repository expectation")
    
    override func setUpWithError() throws {
        self.remoteDataSource = MockFirestoreDataSource()
        self.cacheDataSource = MockLocalCacheDataSource()
        self.settingsBundleDataSource = MockSettingsBundleDataSource()
        self.userDefaults = MockUserDefaults()
        
        self.repository = PetProjectsRepositoryImpl(remoteDataSource: self.remoteDataSource!, cacheDataSource: self.cacheDataSource!, settingsBundleDataSource: self.settingsBundleDataSource!, userDefaults: self.userDefaults!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let stringField = PetProjectFieldStringValueFirestoreModel(stringValue: "abc")
        let integerField = PetProjectFieldIntegerValueFirestoreModel(integerValue: "123")
        let fields = PetProjectFieldFirestoreModel(titleKey: stringField, subtitleKey: stringField, iconUrl: stringField, headerColor: stringField, linkAppStore: stringField, linkPlayStore: stringField, linkWeb: stringField, downloads: integerField)
        let firestoreModel = PetProjectFirestoreModel(name: "abc123", fields: fields)
        let array = [firestoreModel, firestoreModel]
        let documents = PetProjectDocumentsFirestoreModel(documents: array)
        self.remoteDataSource?.fetchPetProjectsResult = .success(documents)
        
        let result = await self.repository?.fetch()
        switch result {
        case .success(let repositoryModel):
            XCTAssertEqual(repositoryModel.items.count, array.count)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
