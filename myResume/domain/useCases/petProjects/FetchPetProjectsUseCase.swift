//
//  FetchPetProjectsUseCase.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import Foundation

protocol FetchPetProjectsUseCase {
    func fetch() async -> Result<PetProjectUseCaseModel, Error>
}

class FetchPetProjectsUseCaseImpl: FetchPetProjectsUseCase {
    private let repository: PetProjectsRepository
    
    init(repository: PetProjectsRepository) {
        self.repository = repository
    }
    
    func fetch() async -> Result<PetProjectUseCaseModel, Error> {
        let result = await repository.fetch()
        switch result {
        case .success(let repositoryModel):
            let items = repositoryModel.items.map { petProjectFirestoreModel in
                return PetProjectItemUseCaseModel(from: petProjectFirestoreModel)
            }
            let sorted = items.sorted { modelA, modelB in
                guard let downloadsA = modelA.downloads else { return false }
                guard let downloadsB = modelB.downloads else { return true }
                return downloadsA > downloadsB
            }
            let useCaseModel = PetProjectUseCaseModel(type: repositoryModel.type, items: sorted)
            return .success(useCaseModel)
        case .failure(let error):
            return .failure(error)
        }
    }
}
