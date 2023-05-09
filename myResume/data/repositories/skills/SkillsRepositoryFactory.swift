//
//  SkillsRepositoryFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

enum SkillsRepositoryFactory {
    static func make() -> SkillsRepository {
        let dataSource = JsonDataSourceFactory.make()
        return SkillsRepositoryImpl(dataSource: dataSource)
    }
}
