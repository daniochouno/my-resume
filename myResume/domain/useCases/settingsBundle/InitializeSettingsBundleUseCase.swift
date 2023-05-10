//
//  SetSettingsBundleUseCase.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

protocol InitializeSettingsBundleUseCase {
    func initialize()
}

class InitializeSettingsBundleUseCaseImpl: InitializeSettingsBundleUseCase {
    private let repository: SettingsBundleRepository
    
    init(repository: SettingsBundleRepository) {
        self.repository = repository
    }
    
    func initialize() {
        repository.clearLocalCacheIfNeeded()
        repository.setDefaultValues()
    }
}
