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
        self.errorMessage = "Error"
    }
}
