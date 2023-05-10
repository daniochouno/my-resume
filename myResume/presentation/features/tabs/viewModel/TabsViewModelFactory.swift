//
//  TabsViewModelFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

enum TabsViewModelFactory {
    static func make() -> TabsViewModel {
        let initializeSettingsBundleUseCase = InitializeSettingsBundleUseCaseFactory.make()
        return TabsViewModel(initializeSettingsBundleUseCase: initializeSettingsBundleUseCase)
    }
}
