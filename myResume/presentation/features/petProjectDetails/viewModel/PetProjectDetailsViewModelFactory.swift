//
//  PetProjectDetailsViewModelFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 23/5/23.
//

import Foundation

enum PetProjectDetailsViewModelFactory {
    static func make(id: String) -> PetProjectDetailsViewModel {
        return PetProjectDetailsViewModel(id: id, fetchPetProjectDetailsUseCase: FetchPetProjectDetailsUseCaseFactory.make())
    }
}
