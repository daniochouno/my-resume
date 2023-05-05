//
//  PetProjectsInteractor.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

protocol PetProjectsInteractor {
    func getListOfPetProjects() async -> Result<[PetProjectEntity], Error>
}

class PetProjectsInteractorImpl: PetProjectsInteractor {
    private let fetchPetProjectsUseCase: FetchPetProjectsUseCase
    
    init(fetchPetProjectsUseCase: FetchPetProjectsUseCase) {
        self.fetchPetProjectsUseCase = fetchPetProjectsUseCase
    }
    
    func getListOfPetProjects() async -> Result<[PetProjectEntity], Error> {
        let result = await fetchPetProjectsUseCase.fetch()
        switch result {
        case .success(let petProjectUseCaseModels):
            let petProjects = petProjectUseCaseModels.map { petProjectUseCaseModel in
                return PetProjectEntity(from: petProjectUseCaseModel)
            }
            return .success(petProjects)
        case .failure(let error):
            return .failure(error)
        }
    }
}
