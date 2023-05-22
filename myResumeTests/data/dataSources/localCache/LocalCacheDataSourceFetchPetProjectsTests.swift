//
//  LocalCacheDataSourceFetchPetProjectsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceFetchPetProjectsTests: XCTestCase {
    var userDefaults: MockUserDefaults?
    var dataSource: LocalCacheDataSource?
    
    override func setUpWithError() throws {
        self.userDefaults = MockUserDefaults()
        
        self.dataSource = LocalCacheDataSourceImpl(userDefaults: self.userDefaults!)
    }

    override func tearDownWithError() throws {
        self.userDefaults?.removeObject(forKey: LocalCacheKey.cachePetProjects.rawValue)
    }

    func testSuccess() throws {
        let now = Date().timeIntervalSince1970
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let integerField = FieldIntegerFirestoreModel(integerValue: "123")
        let fields = PetProjectFieldFirestoreModel(titleKey: stringField, subtitleKey: stringField, iconUrl: stringField, headerColor: stringField, linkAppStore: stringField, linkPlayStore: stringField, linkWeb: stringField, downloads: integerField)
        let firestoreModel = PetProjectFirestoreModel(name: "abc123", fields: fields)
        let array = [firestoreModel, firestoreModel]
        let documents = PetProjectDocumentsFirestoreModel(documents: array)
        let model = PetProjectsLocalCacheModel(createdAt: now, documents: documents)
        do {
            let data = try JSONEncoder().encode(model)
            self.userDefaults?.set(data, forKey: LocalCacheKey.cachePetProjects.rawValue)
        } catch {
            XCTFail("Unexpected parser error")
        }
        
        let result = self.dataSource?.fetchPetProjects()
        switch result {
        case .success(let documents):
            let petProjects = documents.documents.documents
            XCTAssertEqual(petProjects.count, 2, "Found \(petProjects.count) expected pet projects")
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }

    func testFailureParser() async {
        let result = self.dataSource?.fetchPetProjects()
        switch result {
        case .success:
            XCTFail("Unexpected success response")
        case .failure(let error):
            guard let error = error as? APIResponseError else {
                XCTFail("Unexpected error received")
                return
            }
            
            XCTAssertEqual(error, APIResponseError.parser, "Parser error was expected")
        default:
            XCTFail("Unexpected case")
        }
    }
}
