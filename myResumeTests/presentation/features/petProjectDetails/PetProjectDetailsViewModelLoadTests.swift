//
//  PetProjectDetailsViewModelLoadTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 24/5/23.
//

import XCTest
@testable import myResume

final class PetProjectDetailsViewModelLoadTests: XCTestCase {
    let documentId = "abcdef"
    
    var fetchPetProjectDetailsUseCase: MockFetchPetProjectDetailsUseCase?
    
    var viewModel: PetProjectDetailsViewModel?

    override func setUpWithError() throws {
        self.fetchPetProjectDetailsUseCase = MockFetchPetProjectDetailsUseCase()
        
        self.viewModel = PetProjectDetailsViewModel(id: documentId, fetchPetProjectDetailsUseCase: self.fetchPetProjectDetailsUseCase!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let item = PetProjectDetailsItemUseCaseModel(titleKey: "abc", subtitleKey: "abc", iconUrl: "abc", headerColor: "abc", downloads: 9000, linkAppStore: "abc", linkPlayStore: "abc", linkWeb: "abc")
        let model = PetProjectDetailsUseCaseModel(type: .localCache, item: item)
        var data = [String: Result<PetProjectDetailsUseCaseModel, Error>]()
        data[documentId] = .success(model)
        self.fetchPetProjectDetailsUseCase?.fetchResult = data
        
        await self.viewModel?.load()
        
        guard let petProjectDetailsLoaded = self.viewModel?.petProjectDetails else {
            XCTFail("Pet Project Details not loaded")
            return
        }
        
        XCTAssertEqual(petProjectDetailsLoaded.downloads, "9k")
    }
}
