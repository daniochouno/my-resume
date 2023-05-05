//
//  PetProjectsPresenter.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

final class PetProjectsPresenter: ObservableObject {
    private let interactor: PetProjectsInteractor
    
    @Published var isLoading = true
    @Published var petProjects: [PetProjectEntity] = []
    @Published var errorMessage: String?
    
    init(interactor: PetProjectsInteractor) {
        self.interactor = interactor
    }
    
    @MainActor
    func onViewAppear() async {
        self.isLoading = true
        let result = await interactor.getListOfPetProjects()
        switch result {
        case .success(let petProjects):
            self.petProjects = petProjects
        case .failure(let error):
            self.errorMessage = "\(error)"
        }
        self.isLoading = false
    }
}
