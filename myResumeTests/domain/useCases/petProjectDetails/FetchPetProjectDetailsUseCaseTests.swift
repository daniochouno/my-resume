//
//  FetchPetProjectDetailsUseCaseTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 24/5/23.
//

import XCTest
@testable import myResume

final class FetchPetProjectDetailsUseCaseTests: XCTestCase {
    var repository: MockPetProjectsRepository?
    
    var useCase: FetchPetProjectDetailsUseCase?
    let expectation = XCTestExpectation(description: "UseCase expectation")
    
    override func setUpWithError() throws {
        self.repository = MockPetProjectsRepository()
        
        self.useCase = FetchPetProjectDetailsUseCaseImpl(repository: self.repository!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let documentId = "abc123"
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let integerField = FieldIntegerFirestoreModel(integerValue: "8000")
        let fields = PetProjectDetailsFieldFirestoreModel(titleKey: stringField, subtitleKey: stringField, iconUrl: stringField, headerColor: stringField, downloads: integerField, linkAppStore: stringField, linkPlayStore: stringField, linkWeb: stringField, descriptionLargeKey: stringField)
        let petProjectDetailsFirestoreModel = PetProjectDetailsFirestoreModel(name: "abc123", fields: fields)
        let repositoryModel = PetProjectDetailsRepositoryModel(type: .localCache, item: petProjectDetailsFirestoreModel)
        let dictionary: [String: Result<PetProjectDetailsRepositoryModel, Error>] = [
            documentId: .success(repositoryModel)
        ]
        self.repository?.fetchDetailsResult = dictionary
        
        let result = await self.useCase?.fetch(id: documentId)
        switch result {
        case .success(let petProjectUseCaseModel):
            let downloads = petProjectUseCaseModel.item.downloads ?? 0
            XCTAssertEqual(downloads, 8000)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
