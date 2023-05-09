//
//  SkillsViewModelFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

enum SkillsViewModelFactory {
    static func make() -> SkillsViewModel {
        return SkillsViewModel(fetchSkillSectionsUseCase: FetchSkillSectionsUseCaseFactory.make())
    }
}
