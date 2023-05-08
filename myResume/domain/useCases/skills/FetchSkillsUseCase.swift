//
//  FetchSkillsUseCase.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

protocol FetchSkillsUseCase {
    func fetch() async -> Result<[SkillSectionUseCaseModel], Error>
}

class FetchSkillsUseCaseImpl: FetchSkillsUseCase {
    private let repository: SkillsRepository
    
    init(repository: SkillsRepository) {
        self.repository = repository
    }
    
    func fetch() async -> Result<[SkillSectionUseCaseModel], Error> {
        return .failure(APIResponseError.configuration)
    }
}
