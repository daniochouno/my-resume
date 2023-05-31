//
//  SplashViewFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 31/5/23.
//

import SwiftUI

enum SplashViewFactory {
    static func makeView(isSplashBeingDisplayed: Binding<Bool>) -> some View {
        let viewModel = SplashViewModelFactory.make()
        return SplashView(isSplashBeingDisplayed: isSplashBeingDisplayed, viewModel: viewModel)
    }
}
