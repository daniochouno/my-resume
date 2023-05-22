//
//  FetchPetProjectDetailsUseCase.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import Foundation

protocol FetchPetProjectDetailsUseCase {
    func fetch(id: String) async -> Result<PetProjectDetailsUseCaseModel, Error>
}

class FetchPetProjectDetailsUseCaseImpl: FetchPetProjectDetailsUseCase {
    private let repository: PetProjectsRepository
    
    init(repository: PetProjectsRepository) {
        self.repository = repository
    }
    
    func fetch(id: String) async -> Result<PetProjectDetailsUseCaseModel, Error> {
        let result = await repository.fetchDetails(id: id)
        switch result {
        case .success(let repositoryModel):
            let item = PetProjectDetailsItemUseCaseModel(from: repositoryModel.item)
            let useCaseModel = PetProjectDetailsUseCaseModel(type: repositoryModel.type, item: item)
            return .success(useCaseModel)
        case .failure(let error):
            return .failure(error)
        }
    }
}
