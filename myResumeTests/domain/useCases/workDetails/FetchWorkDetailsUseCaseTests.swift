//
//  FetchWorkDetailsUseCaseTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import XCTest
@testable import myResume

final class FetchWorkDetailsUseCaseTests: XCTestCase {
    var repository: MockWorksRepository?
    
    var useCase: FetchWorkDetailsUseCase?
    let expectation = XCTestExpectation(description: "UseCase expectation")
    
    override func setUpWithError() throws {
        self.repository = MockWorksRepository()
        
        self.useCase = FetchWorkDetailsUseCaseImpl(repository: self.repository!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let documentId = "abc123"
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let timestampField = FieldTimestampFirestoreModel(timestampValue: "2023-04-28T00:00:00.000Z")
        let arrayValues = FieldArrayValueFirestoreModel(values: [stringField, stringField, stringField])
        let arrayField = FieldArrayFirestoreModel(arrayValue: arrayValues)
        let fields = WorkDetailsFieldFirestoreModel(company: stringField, companyLogoUrl: stringField, titleKey: stringField, location: stringField, startDate: timestampField, endDate: timestampField, summaryKey: stringField, goalsAchievedKeys: arrayField)
        let workDetailsFirestoreModel = WorkDetailsFirestoreModel(name: documentId, fields: fields)
        let repositoryModel = WorkDetailsRepositoryModel(type: .localCache, item: workDetailsFirestoreModel)
        let dictionary: [String: Result<WorkDetailsRepositoryModel, Error>] = [
            documentId: .success(repositoryModel)
        ]
        self.repository?.fetchDetailsResult = dictionary
        
        let result = await self.useCase?.fetch(id: documentId)
        switch result {
        case .success(let workUseCaseModel):
            let goalsAchieved = workUseCaseModel.item.goalsAchieved ?? []
            XCTAssertEqual(goalsAchieved.count, arrayValues.values.count)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
