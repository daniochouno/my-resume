//
//  FetchWorksUseCaseFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

enum FetchWorksUseCaseFactory {
    static func make() -> FetchWorksUseCase {
        let repository = WorksRepositoryFactory.make()
        return FetchWorksUseCaseImpl(repository: repository)
    }
}
