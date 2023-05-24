//
//  PetProjectDetailsViewModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 23/5/23.
//

import Foundation

final class PetProjectDetailsViewModel: ObservableObject {
    private let id: String
    private let fetchPetProjectDetailsUseCase: FetchPetProjectDetailsUseCase
    
    @Published var isLoading = true
    @Published var petProjectDetails: PetProjectDetailsModel?
    @Published var dataLoadedOrigin: String?
    @Published var errorMessage: String?
    
    init(id: String, fetchPetProjectDetailsUseCase: FetchPetProjectDetailsUseCase) {
        self.id = id
        self.fetchPetProjectDetailsUseCase = fetchPetProjectDetailsUseCase
    }
    
    @MainActor
    func load() async {
        self.isLoading = true
        let result = await fetchPetProjectDetailsUseCase.fetch(id: id)
        switch result {
        case .success(let petProjectDetailsUseCaseModel):
            self.dataLoadedOrigin = "data.origin.\(petProjectDetailsUseCaseModel.type.rawValue)"
            self.petProjectDetails = PetProjectDetailsModel(from: petProjectDetailsUseCaseModel.item)
        case .failure(let error):
            self.errorMessage = "\(error)"
        }
        self.isLoading = false
    }
}
