//
//  LocalCacheDataSourceRemovePetProjectsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 18/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceRemovePetProjectsTests: XCTestCase {
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
        
        self.dataSource?.removePetProjects()
        
        if let _ = self.userDefaults?.data(forKey: LocalCacheKey.cachePetProjects.rawValue) {
            XCTFail("Unexpected error removing pet projects")
            return
        }
    }
}
