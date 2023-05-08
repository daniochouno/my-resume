//
//  SkillSectionModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

struct SkillSectionModel: Identifiable, Equatable {
    let id: UUID
    let title: String
    let order: Int
    let items: [SkillModel]
}

extension SkillSectionModel {
    init(from useCaseModel: SkillSectionUseCaseModel) {
        self.id = UUID()
        self.title = useCaseModel.title
        self.order = useCaseModel.order
        self.items = useCaseModel.items.map { SkillModel(from: $0) }
    }
}
