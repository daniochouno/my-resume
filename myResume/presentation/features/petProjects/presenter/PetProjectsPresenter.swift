//
//  PetProjectsPresenter.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import SwiftUI

final class PetProjectsPresenter: ObservableObject {
    private let interactor: PetProjectsInteractor
    private let router: PetProjectsRouter
    
    @Published var isLoading = true
    @Published var petProjects: [PetProjectItemEntity] = []
    @Published var dataLoadedOrigin: String?
    @Published var errorMessage: String?
    
    init(interactor: PetProjectsInteractor, router: PetProjectsRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    @MainActor
    func onViewAppear() async {
        self.isLoading = true
        let result = await interactor.getListOfPetProjects()
        switch result {
        case .success(let petProjectEntity):
            self.dataLoadedOrigin = "data.origin.\(petProjectEntity.type.rawValue)"
            self.petProjects = petProjectEntity.items
        case .failure(let error):
            self.errorMessage = "\(error)"
        }
        self.isLoading = false
    }
    
    func detailsView(id: String) -> some View {
        router.details(id: id)
    }
}
