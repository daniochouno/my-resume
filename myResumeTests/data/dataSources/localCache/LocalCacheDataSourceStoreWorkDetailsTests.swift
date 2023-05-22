//
//  LocalCacheDataSourceStoreWorkDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 18/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceStoreWorkDetailsTests: XCTestCase {
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
        
        //let documents = WorkDocumentsFirestoreModel(documents: arrayWorks)
        
        guard let result = self.dataSource?.storeWorkDetails(id: workDetailsId, item: workFirestoreModel) else {
            XCTFail("Unexpected error storing works")
            return
        }
        if !result {
            XCTFail("Unexpected error storing works")
        }
        
        let key = LocalCacheKey.cacheWorkDetails.rawValue + "." + workDetailsId
        guard let data = self.userDefaults?.data(forKey: key) else {
            XCTFail("Unexpected error storing works")
            return
        }
        do {
            let decoded = try JSONDecoder().decode(WorkDetailsLocalCacheModel.self, from: data)
            let goalsAchieved = decoded.item.fields.goalsAchievedKeys?.arrayValue.values.count ?? 0
            XCTAssertEqual(goalsAchieved, arrayValue.values.count, "Found \(goalsAchieved) expected works")
        } catch {
            XCTFail("Unexpected parser error")
        }
    }
}
