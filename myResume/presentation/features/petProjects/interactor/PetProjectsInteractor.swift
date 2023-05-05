//
//  PetProjectsInteractor.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

class PetProjectsInteractor {
    private let fetchPetProjectsUseCase: FetchPetProjectsUseCase
    
    init(fetchPetProjectsUseCase: FetchPetProjectsUseCase) {
        self.fetchPetProjectsUseCase = fetchPetProjectsUseCase
    }
    
    func getListOfPetProjects() async -> [PetProjectEntity]? {
        return nil
    }
}
