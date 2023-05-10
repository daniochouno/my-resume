//
//  SetSettingsBundleUseCaseFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 10/5/23.
//

import Foundation

enum SetSettingsBundleUseCaseFactory {
    static func make() -> SetSettingsBundleUseCase {
        let repository = SettingsBundleRepositoryFactory.make()
        return SetSettingsBundleUseCaseImpl(repository: repository)
    }
}
