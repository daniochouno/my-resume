//
//  WorksViewModelLoadTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 28/4/23.
//

import XCTest
@testable import myResume

final class WorksViewModelLoadTests: XCTestCase {
    var fetchWorksUseCase: MockFetchWorksUseCase?
    
    var viewModel: WorksViewModel?

    override func setUpWithError() throws {
        self.fetchWorksUseCase = MockFetchWorksUseCase()
        
        self.viewModel = WorksViewModel(fetchWorksUseCase: self.fetchWorksUseCase!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let model = WorkUseCaseModel(company: "abc", title: "def", location: "ghi", startDate: Date(), endDate: nil)
        let arrayModels = [model, model, model, model]
        self.fetchWorksUseCase?.fetchResult = .success(arrayModels)
        
        await self.viewModel?.load()
        
        guard let worksLoaded = self.viewModel?.works else {
            XCTFail("Works not loaded")
            return
        }
        
        XCTAssertEqual(worksLoaded.count, arrayModels.count)
    }
}
