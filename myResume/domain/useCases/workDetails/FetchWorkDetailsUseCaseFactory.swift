//
//  FetchWorkDetailsUseCaseFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

enum FetchWorkDetailsUseCaseFactory {
    static func make() -> FetchWorkDetailsUseCase {
        let repository = WorksRepositoryFactory.make()
        return FetchWorkDetailsUseCaseImpl(repository: repository)
    }
}
