//
//  FetchWorksUseCaseTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 28/4/23.
//

import XCTest
@testable import myResume

final class FetchWorksUseCaseTests: XCTestCase {
    var repository: MockWorksRepository?
    
    var useCase: FetchWorksUseCase?
    let expectation = XCTestExpectation(description: "UseCase expectation")
    
    override func setUpWithError() throws {
        self.repository = MockWorksRepository()
        
        self.useCase = FetchWorksUseCaseImpl(repository: self.repository!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let stringField = FieldStringFirestoreModel(stringValue: "abc")
        let timestampField = FieldTimestampFirestoreModel(timestampValue: "2023-04-28T00:00:00.000Z")
        let fields = WorkFieldFirestoreModel(company: stringField, companyLogoUrl: stringField, titleKey: stringField, location: stringField, startDate: timestampField, endDate: timestampField)
        let workFirestoreModel = WorkFirestoreModel(name: "abc123", fields: fields)
        let arrayWorks = [workFirestoreModel, workFirestoreModel]
        let repositoryModel = WorkRepositoryModel(type: .localCache, items: arrayWorks)
        self.repository?.fetchResult = .success(repositoryModel)
        
        let result = await self.useCase?.fetch()
        switch result {
        case .success(let workUseCaseModel):
            XCTAssertEqual(workUseCaseModel.items.count, arrayWorks.count)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        default:
            XCTFail("Unexpected case")
        }
    }
}
