//
//  PetProjectsRouterFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 24/5/23.
//

import Foundation

enum PetProjectsRouterFactory {
    static func make() -> PetProjectsRouter {
        return PetProjectsRouter()
    }
}
