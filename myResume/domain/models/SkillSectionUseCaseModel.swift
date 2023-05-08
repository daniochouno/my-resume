//
//  SkillSectionUseCaseModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

struct SkillSectionUseCaseModel: Decodable {
    let title: String
    let order: Int
    let items: [SkillUseCaseModel]
}

extension SkillSectionUseCaseModel {
    init(from jsonModel: SkillSectionJsonModel) {
        self.title = jsonModel.title
        self.order = jsonModel.order
        self.items = jsonModel.items.map { SkillUseCaseModel(from: $0) }
    }
}
