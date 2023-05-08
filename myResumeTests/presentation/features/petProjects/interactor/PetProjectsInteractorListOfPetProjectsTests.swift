//
//  PetProjectsInteractorListOfPetProjectsTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import XCTest
@testable import myResume

final class PetProjectsInteractorListOfPetProjectsTests: XCTestCase {
    var fetchPetProjectsUseCase: MockFetchPetProjectsUseCase?
    
    var interactor: PetProjectsInteractor?

    override func setUpWithError() throws {
        self.fetchPetProjectsUseCase = MockFetchPetProjectsUseCase()
        
        self.interactor = PetProjectsInteractorImpl(fetchPetProjectsUseCase: self.fetchPetProjectsUseCase!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let model = PetProjectUseCaseModel(titleKey: "abc", subtitleKey: "def", iconUrl: "abc", headerColor: "#ffffff", linkAppStore: "abc", linkPlayStore: "abc", linkWeb: "abc", downloads: 10)
        let arrayModels = [model, model, model, model]
        self.fetchPetProjectsUseCase?.fetchResult = .success(arrayModels)
        
        let result = await self.interactor?.getListOfPetProjects()
        switch result {
        case .success(let petProjects):
            XCTAssertEqual(petProjects.count, arrayModels.count)
        default:
            XCTFail("Pet Projects not loaded")
        }
    }
}
