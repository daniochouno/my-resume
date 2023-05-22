//
//  FetchPetProjectDetailsUseCaseFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import Foundation

enum FetchPetProjectDetailsUseCaseFactory {
    static func make() -> FetchPetProjectDetailsUseCase {
        let repository = PetProjectsRepositoryFactory.make()
        return FetchPetProjectDetailsUseCaseImpl(repository: repository)
    }
}
