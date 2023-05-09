//
//  LocalCacheDataSourceStoreWorksTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceStoreWorksTests: XCTestCase {
    var userDefaults: MockUserDefaults?
    var dataSource: LocalCacheDataSource?
    
    override func setUpWithError() throws {
        self.userDefaults = MockUserDefaults()
        
        self.dataSource = LocalCacheDataSourceImpl(userDefaults: self.userDefaults!)
    }

    override func tearDownWithError() throws {
        self.userDefaults?.removeObject(forKey: "works")
    }

    func testSuccess() throws {
        let stringField = WorkFieldStringValueFirestoreModel(stringValue: "abc")
        let timestampField = WorkFieldTimestampValueFirestoreModel(timestampValue: "def")
        let fields = WorkFieldFirestoreModel(company: stringField, title: stringField, location: stringField, startDate: timestampField, endDate: timestampField)
        let workFirestoreModel = WorkFirestoreModel(name: "abc123", fields: fields)
        let arrayWorks = [workFirestoreModel, workFirestoreModel]
        let documents = WorkDocumentsFirestoreModel(documents: arrayWorks)
        
        guard let result = self.dataSource?.storeWorks(documents: documents) else {
            XCTFail("Unexpected error storing works")
            return
        }
        if !result {
            XCTFail("Unexpected error storing works")
        }
        
        guard let data = self.userDefaults?.data(forKey: "works") else {
            XCTFail("Unexpected error storing works")
            return
        }
        do {
            let decoded = try JSONDecoder().decode(WorksLocalCacheModel.self, from: data)
            let works = decoded.documents.documents
            XCTAssertEqual(works.count, 2, "Found \(works.count) expected works")
        } catch {
            XCTFail("Unexpected parser error")
        }
    }
}
