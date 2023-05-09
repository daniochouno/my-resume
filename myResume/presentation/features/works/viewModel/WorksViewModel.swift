//
//  WorksViewModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

final class WorksViewModel: ObservableObject {
    private let fetchWorksUseCase: FetchWorksUseCase
    
    @Published var isLoading = true
    @Published var works: [WorkModel] = []
    @Published var dataLoadedOrigin: String?
    @Published var errorMessage: String?
    
    init(fetchWorksUseCase: FetchWorksUseCase) {
        self.fetchWorksUseCase = fetchWorksUseCase
    }
    
    @MainActor
    func load() async {
        self.isLoading = true
        let result = await fetchWorksUseCase.fetch()
        switch result {
        case .success(let workUseCaseModel):
            self.dataLoadedOrigin = "petProjects.origin.\(workUseCaseModel.type.rawValue)"
            let works = workUseCaseModel.items.map { workItemUseCaseModel in
                return WorkModel(from: workItemUseCaseModel)
            }
            self.works = works
        case .failure(let error):
            self.errorMessage = "\(error)"
        }
        self.isLoading = false
    }
}
