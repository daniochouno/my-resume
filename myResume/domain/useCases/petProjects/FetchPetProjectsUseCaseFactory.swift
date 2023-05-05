//
//  FetchPetProjectsUseCaseFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

enum FetchPetProjectsUseCaseFactory {
    static func make() -> FetchPetProjectsUseCase {
        let repository = PetProjectsRepositoryFactory.make()
        return FetchPetProjectsUseCaseImpl(repository: repository)
    }
}
