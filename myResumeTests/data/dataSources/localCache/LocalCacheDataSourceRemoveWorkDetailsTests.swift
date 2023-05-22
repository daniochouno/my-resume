//
//  LocalCacheDataSourceRemoveWorkDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 18/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceRemoveWorkDetailsTests: XCTestCase {
    var userDefaults: MockUserDefaults?
    var dataSource: LocalCacheDataSource?
    
    override func setUpWithError() throws {
        self.userDefaults = MockUserDefaults()
        
        self.dataSource = LocalCacheDataSourceImpl(userDefaults: self.userDefaults!)
    }

    override func tearDownWithError() throws {
        guard let allData = self.userDefaults?.dictionaryRepresentation() else { return }
        let keys = allData.keys.filter { $0.hasPrefix(LocalCacheKey.cacheWorkDetails.rawValue + ".") }
        for key in keys {
            self.userDefaults?.removeObject(forKey: key)
        }
    }

    func testSuccess() throws {
        let workDetailsId = UUID().uuidString
        let now = Date().timeIntervalSince1970
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let timestampField = FieldTimestampFirestoreModel(timestampValue: "def")
        let arrayValue = FieldArrayValueFirestoreModel(values: [stringField, stringField, stringField])
        let arrayField = FieldArrayFirestoreModel(arrayValue: arrayValue)
        let fields = WorkDetailsFieldFirestoreModel(company: stringField, companyLogoUrl: stringField, titleKey: stringField, location: stringField, startDate: timestampField, endDate: timestampField, summaryKey: stringField, goalsAchievedKeys: arrayField)
        let workFirestoreModel = WorkDetailsFirestoreModel(name: "abc123", fields: fields)
        let model = WorkDetailsLocalCacheModel(createdAt: now, item: workFirestoreModel)
        let key = LocalCacheKey.cacheWorkDetails.rawValue + "." + workDetailsId
        do {
            let data = try JSONEncoder().encode(model)
            self.userDefaults?.set(data, forKey: key)
        } catch {
            XCTFail("Unexpected parser error")
        }
        
        self.dataSource?.removeWorkDetails()
        
        if let _ = self.userDefaults?.data(forKey: key) {
            XCTFail("Unexpected error removing works")
            return
        }
    }
}
