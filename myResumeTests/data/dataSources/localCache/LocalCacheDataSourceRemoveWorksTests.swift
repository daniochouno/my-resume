//
//  LocalCacheDataSourceRemoveWorksTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 18/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceRemoveWorksTests: XCTestCase {
    var userDefaults: MockUserDefaults?
    var dataSource: LocalCacheDataSource?
    
    override func setUpWithError() throws {
        self.userDefaults = MockUserDefaults()
        
        self.dataSource = LocalCacheDataSourceImpl(userDefaults: self.userDefaults!)
    }

    override func tearDownWithError() throws {
        self.userDefaults?.removeObject(forKey: LocalCacheKey.cacheWorks.rawValue)
    }

    func testSuccess() throws {
        let now = Date().timeIntervalSince1970
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let timestampField = FieldTimestampFirestoreModel(timestampValue: "2023-04-28T00:00:00.000Z")
        let fields = WorkFieldFirestoreModel(company: stringField, companyLogoUrl: stringField, titleKey: stringField, location: stringField, startDate: timestampField, endDate: timestampField)
        let workFirestoreModel = WorkFirestoreModel(name: "abc123", fields: fields)
        let arrayWorks = [workFirestoreModel, workFirestoreModel]
        let documents = WorkDocumentsFirestoreModel(documents: arrayWorks)
        let model = WorksLocalCacheModel(createdAt: now, documents: documents)
        do {
            let data = try JSONEncoder().encode(model)
            self.userDefaults?.set(data, forKey: LocalCacheKey.cacheWorks.rawValue)
        } catch {
            XCTFail("Unexpected parser error")
        }
        
        self.dataSource?.removeWorks()
        
        if let _ = self.userDefaults?.data(forKey: LocalCacheKey.cacheWorks.rawValue) {
            XCTFail("Unexpected error removing works")
            return
        }
    }
}
