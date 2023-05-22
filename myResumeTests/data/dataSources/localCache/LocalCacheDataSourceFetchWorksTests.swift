//
//  LocalCacheDataSourceFetchWorksTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceFetchWorksTests: XCTestCase {
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
        let timestampField = FieldTimestampFirestoreModel(timestampValue: "def")
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
        
        let result = self.dataSource?.fetchWorks()
        switch result {
        case .success(let documents):
            let works = documents.documents.documents
            XCTAssertEqual(works.count, 2, "Found \(works.count) expected works")
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }

    func testFailureParser() async {
        let result = self.dataSource?.fetchWorks()
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
