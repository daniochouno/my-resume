//
//  WorksViewModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

final class WorksViewModel: ObservableObject {
    private let fetchWorksUseCase: FetchWorksUseCase
    
    @Published var works: [WorkModel] = []
    @Published var errorMessage: String?
    
    init(fetchWorksUseCase: FetchWorksUseCase) {
        self.fetchWorksUseCase = fetchWorksUseCase
    }
    
    @MainActor
    func load() async {
        let result = await fetchWorksUseCase.fetch()
        switch result {
        case .success(let workUseCaseModels):
            let works = workUseCaseModels.map { workUseCaseModel in
                return WorkModel(from: workUseCaseModel)
            }
            self.works = works
        case .failure(let error):
            self.errorMessage = "\(error)"
        }
    }
}
