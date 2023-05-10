//
//  SetSettingsBundleUseCase.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

protocol SetSettingsBundleUseCase {
    func set()
}

class SetSettingsBundleUseCaseImpl: SetSettingsBundleUseCase {
    private let repository: SettingsBundleRepository
    
    init(repository: SettingsBundleRepository) {
        self.repository = repository
    }
    
    func set() {
        repository.clearLocalCacheIfNeeded()
        repository.setVersionApp()
    }
}
