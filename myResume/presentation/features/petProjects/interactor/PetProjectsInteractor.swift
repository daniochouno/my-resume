//
//  PetProjectsInteractor.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

protocol PetProjectsInteractor {
    func getListOfPetProjects() async -> Result<PetProjectEntity, Error>
}

class PetProjectsInteractorImpl: PetProjectsInteractor {
    private let fetchPetProjectsUseCase: FetchPetProjectsUseCase
    
    init(fetchPetProjectsUseCase: FetchPetProjectsUseCase) {
        self.fetchPetProjectsUseCase = fetchPetProjectsUseCase
    }
    
    func getListOfPetProjects() async -> Result<PetProjectEntity, Error> {
        let result = await fetchPetProjectsUseCase.fetch()
        switch result {
        case .success(let petProjectUseCaseModel):
            let items = petProjectUseCaseModel.items.map { petProjectItemUseCaseModel in
                return PetProjectItemEntity(from: petProjectItemUseCaseModel)
            }
            let petProjectEntity = PetProjectEntity(type: petProjectUseCaseModel.type, items: items)
            return .success(petProjectEntity)
        case .failure(let error):
            return .failure(error)
        }
    }
}
