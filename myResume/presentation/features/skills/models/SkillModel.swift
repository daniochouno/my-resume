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
    let experienceInYears: Int
    let iconAsset: String
    let foregroundColor: String
    let backgroundColor: String
}

extension SkillModel {
    init(from useCaseModel: SkillUseCaseModel) {
        self.id = UUID()
        self.title = useCaseModel.title
        self.experienceInYears = useCaseModel.experienceInYears
        self.iconAsset = useCaseModel.iconAsset
        self.foregroundColor = useCaseModel.foregroundColor
        self.backgroundColor = useCaseModel.backgroundColor
    }
}

