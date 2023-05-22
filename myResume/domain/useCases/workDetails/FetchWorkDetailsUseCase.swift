//
//  FetchWorkDetailsUseCase.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

protocol FetchWorkDetailsUseCase {
    func fetch(id: String) async -> Result<WorkDetailsUseCaseModel, Error>
}

class FetchWorkDetailsUseCaseImpl: FetchWorkDetailsUseCase {
    private let repository: WorksRepository
    
    init(repository: WorksRepository) {
        self.repository = repository
    }
    
    func fetch(id: String) async -> Result<WorkDetailsUseCaseModel, Error> {
        let result = await repository.fetchDetails(id: id)
        switch result {
        case .success(let repositoryModel):
            let item = WorkDetailsItemUseCaseModel(from: repositoryModel.item)
            let useCaseModel = WorkDetailsUseCaseModel(type: repositoryModel.type, item: item)
            return .success(useCaseModel)
        case .failure(let error):
            return .failure(error)
        }
    }
}
