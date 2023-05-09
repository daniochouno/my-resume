//
//  SkillsViewModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

protocol SkillsViewModelOutput {
    func isLoading()
    func didLoad()
}

final class SkillsViewModel {
    private let fetchSkillSectionsUseCase: FetchSkillSectionsUseCase
    
    var output: SkillsViewModelOutput?
    
    private(set) var sections: [SkillSectionModel]?
    private(set) var errorMessage: String?
    
    init(fetchSkillSectionsUseCase: FetchSkillSectionsUseCase) {
        self.fetchSkillSectionsUseCase = fetchSkillSectionsUseCase
    }
    
    func load() async {
        self.output?.isLoading()
        let result = await fetchSkillSectionsUseCase.fetch()
        switch result {
        case .success(let skillUseCaseModels):
            let sections = skillUseCaseModels.map { skillUseCaseModel in
                return SkillSectionModel(from: skillUseCaseModel)
            }
            self.sections = sections
            self.errorMessage = nil
        case .failure(let error):
            self.sections = nil
            self.errorMessage = "\(error)"
        }
        
        self.output?.didLoad()
    }
}
