//
//  WorkDetailsViewModelFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

enum WorkDetailsViewModelFactory {
    static func make(id: String) -> WorkDetailsViewModel {
        return WorkDetailsViewModel(id: id, fetchWorkDetailsUseCase: FetchWorkDetailsUseCaseFactory.make())
    }
}
