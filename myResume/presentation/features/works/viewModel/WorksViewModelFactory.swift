//
//  WorksViewModelFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

enum WorksViewModelFactory {
    static func make() -> WorksViewModel {
        return WorksViewModel(fetchWorksUseCase: FetchWorksUseCaseFactory.make())
    }
}
