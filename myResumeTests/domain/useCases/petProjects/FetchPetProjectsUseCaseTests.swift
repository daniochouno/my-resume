//
//  FetchPetProjectsUseCaseTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import XCTest
@testable import myResume

final class FetchPetProjectsUseCaseTests: XCTestCase {
    var repository: MockPetProjectsRepository?
    
    var useCase: FetchPetProjectsUseCase?
    let expectation = XCTestExpectation(description: "UseCase expectation")
    
    override func setUpWithError() throws {
        self.repository = MockPetProjectsRepository()
        
        self.useCase = FetchPetProjectsUseCaseImpl(repository: self.repository!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let stringField = PetProjectFieldStringValueFirestoreModel(stringValue: "abc")
        let integerField = PetProjectFieldIntegerValueFirestoreModel(integerValue: "123")
        let fields = PetProjectFieldFirestoreModel(titleKey: stringField, subtitleKey: stringField, iconUrl: stringField, headerColor: stringField, linkAppStore: stringField, linkPlayStore: stringField, linkWeb: stringField, downloads: integerField)
        let firestoreModel = PetProjectFirestoreModel(name: "abc123", fields: fields)
        let arrayPetProjects = [firestoreModel, firestoreModel]
        let repositoryModel = PetProjectRepositoryModel(type: .localCache, items: arrayPetProjects)
        self.repository?.fetchResult = .success(repositoryModel)
        
        let result = await self.useCase?.fetch()
        switch result {
        case .success(let petProjectUseCaseModel):
            XCTAssertEqual(petProjectUseCaseModel.items.count, arrayPetProjects.count)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
