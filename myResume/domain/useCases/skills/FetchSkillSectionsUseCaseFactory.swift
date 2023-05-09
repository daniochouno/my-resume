//
//  FetchSkillSectionsUseCaseFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

enum FetchSkillSectionsUseCaseFactory {
    static func make() -> FetchSkillSectionsUseCase {
        let repository = SkillsRepositoryFactory.make()
        return FetchSkillSectionsUseCaseImpl(repository: repository)
    }
}
