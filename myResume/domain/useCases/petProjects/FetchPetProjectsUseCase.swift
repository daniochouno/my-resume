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
        return .failure(APIResponseError.configuration)
    }
}
