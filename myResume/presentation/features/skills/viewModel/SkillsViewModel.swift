//
//  SkillsViewModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

final class SkillsViewModel: ObservableObject {
    private let fetchSkillSectionsUseCase: FetchSkillSectionsUseCase
    
    @Published var isLoading = true
    @Published var sections: [SkillSectionModel] = []
    @Published var errorMessage: String?
    
    init(fetchSkillSectionsUseCase: FetchSkillSectionsUseCase) {
        self.fetchSkillSectionsUseCase = fetchSkillSectionsUseCase
    }
    
    @MainActor
    func load() async {
        self.isLoading = true
        let result = await fetchSkillSectionsUseCase.fetch()
        switch result {
        case .success(let skillUseCaseModels):
            let sections = skillUseCaseModels.map { skillUseCaseModel in
                return SkillSectionModel(from: skillUseCaseModel)
            }
            self.sections = sections
        case .failure(let error):
            self.errorMessage = "\(error)"
        }
        self.isLoading = false
    }
}
