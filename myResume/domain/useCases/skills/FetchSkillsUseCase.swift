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
        let result = await repository.fetch()
        switch result {
        case .success(let sections):
            let models = sections.map { skillSectionJsonModel in
                return SkillSectionUseCaseModel(from: skillSectionJsonModel)
            }
            return .success(models)
        case .failure(let error):
            return .failure(error)
        }
    }
}
