//
//  LocalCacheDataSourceRemovePetProjectDetailsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import XCTest
@testable import myResume

final class LocalCacheDataSourceRemovePetProjectDetailsTests: XCTestCase {
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
        let integerField = FieldIntegerFirestoreModel(integerValue: "5000")
        let fields = PetProjectDetailsFieldFirestoreModel(titleKey: stringField, subtitleKey: stringField, iconUrl: stringField, headerColor: stringField, downloads: integerField, linkAppStore: stringField, linkPlayStore: stringField)
        let petProjectFirestoreModel = PetProjectDetailsFirestoreModel(name: "abc123", fields: fields)
        let model = PetProjectDetailsLocalCacheModel(createdAt: now, item: petProjectFirestoreModel)
        let key = LocalCacheKey.cachePetProjectDetails.rawValue + "." + petProjectDetailsId
        do {
            let data = try JSONEncoder().encode(model)
            self.userDefaults?.set(data, forKey: key)
        } catch {
            XCTFail("Unexpected parser error")
        }
        
        self.dataSource?.removePetProjectDetails()
        
        if let _ = self.userDefaults?.data(forKey: key) {
            XCTFail("Unexpected error removing pet projects")
            return
        }
    }
}
