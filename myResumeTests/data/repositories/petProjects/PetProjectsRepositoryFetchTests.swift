//
//  PetProjectsRepositoryFetchTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import XCTest
@testable import myResume

final class PetProjectsRepositoryFetchTests: XCTestCase {
    var dataSource: MockFirestoreDataSource?
    var userDefaults: MockUserDefaults?
    
    var repository: PetProjectsRepository?
    let expectation = XCTestExpectation(description: "Repository expectation")
    
    override func setUpWithError() throws {
        self.dataSource = MockFirestoreDataSource()
        self.userDefaults = MockUserDefaults()
        
        self.repository = PetProjectsRepositoryImpl(dataSource: self.dataSource!, userDefaults: self.userDefaults!)
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
        self.dataSource?.fetchPetProjectsResult = .success(documents)
        
        let result = await self.repository?.fetch()
        switch result {
        case .success(let petProjects):
            XCTAssertEqual(petProjects.count, array.count)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
