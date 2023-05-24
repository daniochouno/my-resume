//
//  LocalCacheDataSourceStorePetProjectDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceStorePetProjectDetailsTests: XCTestCase {
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
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let integerField = FieldIntegerFirestoreModel(integerValue: "4000")
        let fields = PetProjectDetailsFieldFirestoreModel(titleKey: stringField, subtitleKey: stringField, iconUrl: stringField, headerColor: stringField, downloads: integerField, linkAppStore: stringField, linkPlayStore: stringField, linkWeb: stringField, descriptionLargeKey: stringField)
        let petProjectFirestoreModel = PetProjectDetailsFirestoreModel(name: "abc123", fields: fields)
        
        guard let result = self.dataSource?.storePetProjectDetails(id: petProjectDetailsId, item: petProjectFirestoreModel) else {
            XCTFail("Unexpected error storing pet projects")
            return
        }
        if !result {
            XCTFail("Unexpected error storing pet projects")
        }
        
        let key = LocalCacheKey.cachePetProjectDetails.rawValue + "." + petProjectDetailsId
        guard let data = self.userDefaults?.data(forKey: key) else {
            XCTFail("Unexpected error storing pet projects")
            return
        }
        do {
            let decoded = try JSONDecoder().decode(PetProjectDetailsLocalCacheModel.self, from: data)
            guard let iDownloads = decoded.item.fields.downloads?.integerValue, let downloads = Int(iDownloads) else {
                XCTFail("Unexpected null downloads")
                return
            }
            XCTAssertEqual(downloads, 4000, "Found Pet Project with \(downloads) downloads")
        } catch {
            XCTFail("Unexpected parser error")
        }
    }
}
