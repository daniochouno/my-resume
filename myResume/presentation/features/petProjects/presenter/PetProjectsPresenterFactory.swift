//
//  PetProjectsPresenterFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation

enum PetProjectsPresenterFactory {
    static func make() -> PetProjectsPresenter {
        let interactor = PetProjectsInteractorFactory.make()
        return PetProjectsPresenter(interactor: interactor)
    }
}
