//
//  FetchPetProjectsUseCase.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import Foundation

protocol FetchPetProjectsUseCase {
    func fetch() async -> Result<[PetProjectUseCaseModel], Error>
}

class FetchPetProjectsUseCaseImpl: FetchPetProjectsUseCase {
    private let repository: PetProjectsRepository
    
    init(repository: PetProjectsRepository) {
        self.repository = repository
    }
    
    func fetch() async -> Result<[PetProjectUseCaseModel], Error> {
        let result = await repository.fetch()
        switch result {
        case .success(let petProjects):
            let models = petProjects.map { petProjectFirestoreModel in
                return PetProjectUseCaseModel(from: petProjectFirestoreModel)
            }
            return .success(models)
        case .failure(let error):
            return .failure(error)
        }
    }
}
