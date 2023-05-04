//
//  FetchWorksUseCase.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

protocol FetchWorksUseCase {
    func fetch() async -> Result<[WorkUseCaseModel], Error>
}

class FetchWorksUseCaseImpl: FetchWorksUseCase {
    private let repository: WorksRepository
    
    init(repository: WorksRepository) {
        self.repository = repository
    }
    
    func fetch() async -> Result<[WorkUseCaseModel], Error> {
        let result = await repository.fetch()
        switch result {
        case .success(let works):
            let models = works.map { workFirestoreModel in
                return WorkUseCaseModel(from: workFirestoreModel)
            }
            let sorted = models.sorted { modelA, modelB in
                return modelA.startDate > modelB.startDate
            }
            return .success(sorted)
        case .failure(let error):
            return .failure(error)
        }
    }
}
