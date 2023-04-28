//
//  WorksViewFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import SwiftUI

enum WorksViewFactory {
    static func makeView() -> some View {
        let viewModel = WorksViewModelFactory.make()
        return WorksView(viewModel: viewModel)
    }
}
