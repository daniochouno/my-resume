//
//  LocalCacheDataSourceFetchWorkDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 18/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceFetchWorkDetailsTests: XCTestCase {
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
        let timestampField = FieldTimestampFirestoreModel(timestampValue: "2023-04-28T00:00:00.000Z")
        let arrayValue = FieldArrayValueFirestoreModel(values: [stringField, stringField, stringField])
        let arrayField = FieldArrayFirestoreModel(arrayValue: arrayValue)
        let fields = WorkDetailsFieldFirestoreModel(company: stringField, companyLogoUrl: stringField, titleKey: stringField, location: stringField, startDate: timestampField, endDate: timestampField, summaryKey: stringField, goalsAchievedKeys: arrayField)
        let workFirestoreModel = WorkDetailsFirestoreModel(name: "abc123", fields: fields)
        let model = WorkDetailsLocalCacheModel(createdAt: now, item: workFirestoreModel)
        do {
            let data = try JSONEncoder().encode(model)
            let key = LocalCacheKey.cacheWorkDetails.rawValue + "." + workDetailsId
            self.userDefaults?.set(data, forKey: key)
        } catch {
            XCTFail("Unexpected parser error")
        }
        
        let result = self.dataSource?.fetchWorkDetails(id: workDetailsId)
        switch result {
        case .success(let details):
            let goalsAchieved = details.item.fields.goalsAchievedKeys?.arrayValue.values.count ?? 0
            XCTAssertEqual(goalsAchieved, arrayValue.values.count, "Found \(goalsAchieved) expected goals achieved")
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }

    func testFailureParser() async {
        let workDetailsId = UUID().uuidString
        let result = self.dataSource?.fetchWorkDetails(id: workDetailsId)
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
