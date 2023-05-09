//
//  LocalCacheDataSourceStorePetOrojectsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceStorePetProjectsTests: XCTestCase {
    var userDefaults: MockUserDefaults?
    var dataSource: LocalCacheDataSource?
    
    override func setUpWithError() throws {
        self.userDefaults = MockUserDefaults()
        
        self.dataSource = LocalCacheDataSourceImpl(userDefaults: self.userDefaults!)
    }

    override func tearDownWithError() throws {
        self.userDefaults?.removeObject(forKey: "petProjects")
    }

    func testSuccess() throws {
        let stringField = PetProjectFieldStringValueFirestoreModel(stringValue: "abc")
        let integerField = PetProjectFieldIntegerValueFirestoreModel(integerValue: "123")
        let fields = PetProjectFieldFirestoreModel(titleKey: stringField, subtitleKey: stringField, iconUrl: stringField, headerColor: stringField, linkAppStore: stringField, linkPlayStore: stringField, linkWeb: stringField, downloads: integerField)
        let firestoreModel = PetProjectFirestoreModel(name: "abc123", fields: fields)
        let array = [firestoreModel, firestoreModel]
        let documents = PetProjectDocumentsFirestoreModel(documents: array)
        
        guard let result = self.dataSource?.storePetProjects(documents: documents) else {
            XCTFail("Unexpected error storing pet projects")
            return
        }
        if !result {
            XCTFail("Unexpected error storing pet projects")
        }
        
        guard let data = self.userDefaults?.data(forKey: "petProjects") else {
            XCTFail("Unexpected error storing pet projects")
            return
        }
        do {
            let decoded = try JSONDecoder().decode(PetProjectsLocalCacheModel.self, from: data)
            let petProjects = decoded.documents.documents
            XCTAssertEqual(petProjects.count, 2, "Found \(petProjects.count) expected pet projects")
        } catch {
            XCTFail("Unexpected parser error")
        }
    }
}
