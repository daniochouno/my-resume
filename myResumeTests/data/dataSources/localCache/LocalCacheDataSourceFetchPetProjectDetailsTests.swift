//
//  LocalCacheDataSourceFetchPetProjectDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceFetchPetProjectDetailsTests: XCTestCase {
    var userDefaults: MockUserDefaults?
    var dataSource: LocalCacheDataSource?
    
    override func setUpWithError() throws {
        self.userDefaults = MockUserDefaults()
        
        self.dataSource = LocalCacheDataSourceImpl(userDefaults: self.userDefaults!)
    }

    override func tearDownWithError() throws {
        guard let allData = self.userDefaults?.dictionaryRepresentation() else { return }
        let keys = allData.keys.filter { $0.hasPrefix(LocalCacheKey.cachePetProjectDetails.rawValue + ".") }
        for key in keys {
            self.userDefaults?.removeObject(forKey: key)
        }
    }

    func testSuccess() throws {
        let petProjectDetailsId = UUID().uuidString
        let now = Date().timeIntervalSince1970
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let integerField = FieldIntegerFirestoreModel(integerValue: "2000")
        let fields = PetProjectDetailsFieldFirestoreModel(titleKey: stringField, subtitleKey: stringField, iconUrl: stringField, headerColor: stringField, downloads: integerField, linkAppStore: stringField, linkPlayStore: stringField, linkWeb: stringField)
        let petProjectFirestoreModel = PetProjectDetailsFirestoreModel(name: "abc123", fields: fields)
        let model = PetProjectDetailsLocalCacheModel(createdAt: now, item: petProjectFirestoreModel)
        do {
            let data = try JSONEncoder().encode(model)
            let key = LocalCacheKey.cachePetProjectDetails.rawValue + "." + petProjectDetailsId
            self.userDefaults?.set(data, forKey: key)
        } catch {
            XCTFail("Unexpected parser error")
        }
        
        let result = self.dataSource?.fetchPetProjectDetails(id: petProjectDetailsId)
        switch result {
        case .success(let details):
            guard let iDownloads = details.item.fields.downloads?.integerValue, let downloads = Int(iDownloads) else {
                XCTFail("Unexpected null downloads")
                return
            }
            XCTAssertEqual(downloads, 2000, "Found Pet Project with \(downloads) downloads")
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }

    func testFailureParser() async {
        let petProjectDetailsId = UUID().uuidString
        let result = self.dataSource?.fetchPetProjectDetails(id: petProjectDetailsId)
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
