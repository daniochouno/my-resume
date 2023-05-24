//
//  PetProjectsPresenterOnViewAppearTests.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import XCTest
@testable import myResume

final class PetProjectsPresenterOnViewAppearTests: XCTestCase {
    var interactor: MockPetProjectsInteractor?
    
    var presenter: PetProjectsPresenter?

    override func setUpWithError() throws {
        self.interactor = MockPetProjectsInteractor()
        let router = PetProjectsRouter()
        
        self.presenter = PetProjectsPresenter(interactor: self.interactor!, router: router)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() async throws {
        let item = PetProjectItemEntity(id: UUID(), documentId: "abc", titleKey: "abc", subtitleKey: "def", iconUrl: "abc", headerColor: "#ffffff", linkAppStore: "abc", linkPlayStore: "abc", linkWeb: "abc", downloads: "abc")
        let items = [item, item, item, item]
        let model = PetProjectEntity(type: .localCache, items: items)
        self.interactor?.getListOfPetProjectsResult = .success(model)
        
        await self.presenter?.onViewAppear()
        
        let petProjects = try XCTUnwrap(self.presenter?.petProjects)
        XCTAssertEqual(petProjects.count, items.count)
    }
}
