//
//  SkillModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

struct SkillModel: Identifiable, Equatable {
    let id: UUID
    let title: String
    let iconAsset: String
}

extension SkillModel {
    init(from useCaseModel: SkillUseCaseModel) {
        self.id = UUID()
        self.title = useCaseModel.title
        self.iconAsset = useCaseModel.iconAsset
    }
}

