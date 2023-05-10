//
//  TabsViewModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

final class TabsViewModel: ObservableObject {
    private let initializeSettingsBundleUseCase: InitializeSettingsBundleUseCase
    
    init(initializeSettingsBundleUseCase: InitializeSettingsBundleUseCase) {
        self.initializeSettingsBundleUseCase = initializeSettingsBundleUseCase
    }
    
    func initializeSettingsBundle() {
        initializeSettingsBundleUseCase.initialize()
    }
}
