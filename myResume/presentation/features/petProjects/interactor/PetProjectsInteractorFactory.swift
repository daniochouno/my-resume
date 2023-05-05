//
//  PetProjectsInteractorFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

enum PetProjectsInteractorFactory {
    static func make() -> PetProjectsInteractor {
        let fetchPetProjectsUseCase = FetchPetProjectsUseCaseFactory.make()
        return PetProjectsInteractorImpl(fetchPetProjectsUseCase: fetchPetProjectsUseCase)
    }
}
