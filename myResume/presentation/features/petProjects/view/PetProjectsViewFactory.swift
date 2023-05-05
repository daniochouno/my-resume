//
//  PetProjectsViewFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import SwiftUI

enum PetProjectsViewFactory {
    static func makeView() -> some View {
        let presenter = PetProjectsPresenterFactory.make()
        return PetProjectsView(presenter: presenter)
    }
}
