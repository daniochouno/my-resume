//
//  SkillsRepository.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

protocol SkillsRepository {
    func fetch() async -> Result<[SkillSectionJsonModel], Error>
}

class SkillsRepositoryImpl: SkillsRepository {
    let dataSource: JsonDataSource
    
    init(dataSource: JsonDataSource) {
        self.dataSource = dataSource
    }
    
    func fetch() async -> Result<[SkillSectionJsonModel], Error> {
        return .failure(APIResponseError.configuration)
    }
}
