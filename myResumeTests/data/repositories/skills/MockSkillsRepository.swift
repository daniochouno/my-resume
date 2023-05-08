//
//  MockSkillsRepository.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation
@testable import myResume

class MockSkillsRepository: SkillsRepository {
    var fetchResult: Result<[SkillSectionJsonModel], Error>?
    
    func fetch() async -> Result<[SkillSectionJsonModel], Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}
