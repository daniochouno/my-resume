//
//  JsonDataSource.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

protocol JsonDataSource {
    func fetchSkills() async -> Result<[SkillSectionJsonModel], Error>
}

class JsonDataSourceImpl: JsonDataSource {
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func fetchSkills() async -> Result<[SkillSectionJsonModel], Error> {
        return .failure(APIResponseError.configuration)
    }
}
