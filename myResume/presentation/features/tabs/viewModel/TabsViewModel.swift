//
//  TabsViewModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

final class TabsViewModel: ObservableObject {
    private let setSettingsBundleUseCase: SetSettingsBundleUseCase
    
    init(setSettingsBundleUseCase: SetSettingsBundleUseCase) {
        self.setSettingsBundleUseCase = setSettingsBundleUseCase
    }
    
    func setSettingsBundle() {
        setSettingsBundleUseCase.set()
    }
}
