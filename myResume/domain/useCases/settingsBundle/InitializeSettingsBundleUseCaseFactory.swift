//
//  SetSettingsBundleUseCaseFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

enum InitializeSettingsBundleUseCaseFactory {
    static func make() -> InitializeSettingsBundleUseCase {
        let repository = SettingsBundleRepositoryFactory.make()
        return InitializeSettingsBundleUseCaseImpl(repository: repository)
    }
}
