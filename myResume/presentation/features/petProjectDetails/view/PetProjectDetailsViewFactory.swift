//
//  PetProjectDetailsViewFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 23/5/23.
//

import SwiftUI

enum PetProjectDetailsViewFactory {
    static func makeView(id: String) -> some View {
        let viewModel = PetProjectDetailsViewModelFactory.make(id: id)
        return PetProjectDetailsView(viewModel: viewModel)
    }
}
