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
        let item = WorkItemUseCaseModel(documentId: "abc", company: "abc", companyLogoUrl: "abc", title: "abc", location: "abc", startDate: Date(), endDate: Date())
        let items = [item, item, item, item]
        let model = WorkUseCaseModel(type: .localCache, items: items)
        self.fetchWorksUseCase?.fetchResult = .success(model)
        
        await self.viewModel?.load()
        
        guard let worksLoaded = self.viewModel?.works else {
            XCTFail("Works not loaded")
            return
        }
        
        XCTAssertEqual(worksLoaded.count, items.count)
    }
}
