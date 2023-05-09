//
//  FetchWorksUseCase.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

protocol FetchWorksUseCase {
    func fetch() async -> Result<WorkUseCaseModel, Error>
}

class FetchWorksUseCaseImpl: FetchWorksUseCase {
    private let repository: WorksRepository
    
    init(repository: WorksRepository) {
        self.repository = repository
    }
    
    func fetch() async -> Result<WorkUseCaseModel, Error> {
        let result = await repository.fetch()
        switch result {
        case .success(let repositoryModel):
            let items = repositoryModel.items.map { workFirestoreModel in
                return WorkItemUseCaseModel(from: workFirestoreModel)
            }
            let sorted = items.sorted { modelA, modelB in
                return modelA.startDate > modelB.startDate
            }
            let useCaseModel = WorkUseCaseModel(type: repositoryModel.type, items: sorted)
            return .success(useCaseModel)
        case .failure(let error):
            return .failure(error)
        }
    }
}
