//
//  WorkDetailsViewModelLoadTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import XCTest
@testable import myResume

final class WorkDetailsViewModelLoadTests: XCTestCase {
    let documentId = "abcdef"
    
    var fetchWorkDetailsUseCase: MockFetchWorkDetailsUseCase?
    
    var viewModel: WorkDetailsViewModel?

    override func setUpWithError() throws {
        self.fetchWorkDetailsUseCase = MockFetchWorkDetailsUseCase()
        
        self.viewModel = WorkDetailsViewModel(id: documentId, fetchWorkDetailsUseCase: self.fetchWorkDetailsUseCase!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let item = WorkDetailsItemUseCaseModel(company: "abc", companyLogoUrl: "abc", title: "abc", location: "abc", startDate: Date(), endDate: Date(), summary: "abc", goalsAchieved: ["abc", "abc"])
        let model = WorkDetailsUseCaseModel(type: .localCache, item: item)
        var data = [String: Result<WorkDetailsUseCaseModel, Error>]()
        data[documentId] = .success(model)
        self.fetchWorkDetailsUseCase?.fetchResult = data
        
        await self.viewModel?.load()
        
        guard let workDetailsLoaded = self.viewModel?.workDetails else {
            XCTFail("Work Details not loaded")
            return
        }
        
        XCTAssertEqual(workDetailsLoaded.goalsAchieved?.count ?? 0, 2)
    }
}
