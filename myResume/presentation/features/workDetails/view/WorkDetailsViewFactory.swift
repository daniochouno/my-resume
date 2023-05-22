//
//  WorkDetailsViewFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 17/5/23.
//

import SwiftUI

enum WorkDetailsViewFactory {
    static func makeView(id: String) -> some View {
        let viewModel = WorkDetailsViewModelFactory.make(id: id)
        return WorkDetailsView(viewModel: viewModel)
    }
}
