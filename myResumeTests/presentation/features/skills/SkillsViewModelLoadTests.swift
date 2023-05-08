//
//  SkillsViewModelLoadTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import XCTest
@testable import myResume

final class SkillsViewModelLoadTests: XCTestCase {
    var fetchSkillSectionsUseCase: MockFetchSkillSectionsUseCase?
    
    var viewModel: SkillsViewModel?

    override func setUpWithError() throws {
        self.fetchSkillSectionsUseCase = MockFetchSkillSectionsUseCase()
        
        self.viewModel = SkillsViewModel(fetchSkillSectionsUseCase: self.fetchSkillSectionsUseCase!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let skill = SkillUseCaseModel(title: "abc", experienceInYears: 1, iconAsset: "abc", foregroundColor: "abc", backgroundColor: "abc")
        let model = SkillSectionUseCaseModel(title: "abc", order: 0, items: [skill, skill])
        let arrayModels = [model, model, model, model]
        self.fetchSkillSectionsUseCase?.fetchResult = .success(arrayModels)
        
        await self.viewModel?.load()
        
        guard let sectionsLoaded = self.viewModel?.sections else {
            XCTFail("Sections not loaded")
            return
        }
        
        XCTAssertEqual(sectionsLoaded.count, arrayModels.count)
    }
}
