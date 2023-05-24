//
//  PetProjectsRepositoryFetchDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import XCTest
@testable import myResume

final class PetProjectsRepositoryFetchDetailsTests: XCTestCase {
    var remoteDataSource: MockFirestoreDataSource?
    var cacheDataSource: MockLocalCacheDataSource?
    var settingsBundleDataSource: MockSettingsBundleDataSource?
    var sessionDataSource: MockSessionDataSource?
    
    var repository: PetProjectsRepository?
    let expectation = XCTestExpectation(description: "Repository expectation")
    
    override func setUpWithError() throws {
        self.remoteDataSource = MockFirestoreDataSource()
        self.cacheDataSource = MockLocalCacheDataSource()
        self.settingsBundleDataSource = MockSettingsBundleDataSource()
        self.sessionDataSource = MockSessionDataSource()
        
        self.repository = PetProjectsRepositoryImpl(remoteDataSource: self.remoteDataSource!, cacheDataSource: self.cacheDataSource!, settingsBundleDataSource: self.settingsBundleDataSource!, sessionDataSource: self.sessionDataSource!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let documentId = "abc123"
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let integerField = FieldIntegerFirestoreModel(integerValue: "7000")
        let fields = PetProjectDetailsFieldFirestoreModel(titleKey: stringField, subtitleKey: stringField, iconUrl: stringField, headerColor: stringField, downloads: integerField, linkAppStore: stringField, linkPlayStore: stringField)
        let petProjectDetailsFirestoreModel = PetProjectDetailsFirestoreModel(name: "abc123", fields: fields)
        self.remoteDataSource?.fetchPetProjectDetailsResult = .success(petProjectDetailsFirestoreModel)
        
        let result = await self.repository?.fetchDetails(id: documentId)
        switch result {
        case .success(let repositoryModel):
            guard let iDownloads = repositoryModel.item.fields.downloads?.integerValue, let downloads = Int(iDownloads) else {
                XCTFail("Unexpected null downloads")
                return
            }
            XCTAssertEqual(downloads, 7000)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
