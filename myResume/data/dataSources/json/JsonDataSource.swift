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
        do {
            let skills: [SkillSectionJsonModel] = try JSONDecoder().decode([SkillSectionJsonModel].self, from: self.data)
            return .success(skills)
        } catch {
            return .failure(APIResponseError.parser)
        }
    }
}
