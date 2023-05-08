//
//  MockJsonDataSource.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation
@testable import myResume

class MockJsonDataSource: JsonDataSource {
    var fetchSkillsResult: Result<[SkillSectionJsonModel], Error>?
    
    func fetchSkills() async -> Result<[SkillSectionJsonModel], Error> {
        guard let result = self.fetchSkillsResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}
