//
//  PetProjectsInteractor.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

class PetProjectsInteractor {
    private let fetchPetProjectsUseCase: FetchPetProjectsUseCase
    
    init(fetchPetProjectsUseCase: FetchPetProjectsUseCase) {
        self.fetchPetProjectsUseCase = fetchPetProjectsUseCase
    }
    
    func getListOfPetProjects() async -> [PetProjectEntity]? {
        let result = await fetchPetProjectsUseCase.fetch()
        switch result {
        case .success(let petProjectUseCaseModels):
            let petProjects = petProjectUseCaseModels.map { petProjectUseCaseModel in
                return PetProjectEntity(from: petProjectUseCaseModel)
            }
            return petProjects
        case .failure:
            return nil
        }
    }
}
