//
//  MockFetchSkillSectionsUseCase.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation
@testable import myResume

class MockFetchSkillSectionsUseCase: FetchSkillSectionsUseCase {
    var fetchResult: Result<[SkillSectionUseCaseModel], Error>?
    
    func fetch() async -> Result<[SkillSectionUseCaseModel], Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}
