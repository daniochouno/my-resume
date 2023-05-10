//
//  TabsViewFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 14/4/23.
//

import SwiftUI

enum TabsViewFactory {
    static func makeView() -> some View {
        let viewModel = TabsViewModelFactory.make()
        return TabsView(viewModel: viewModel)
    }
}
