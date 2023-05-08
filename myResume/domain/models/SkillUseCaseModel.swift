//
//  SkillUseCaseModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

struct SkillUseCaseModel: Decodable {
    let title: String
    let experienceInYears: Int
    let iconAsset: String
    let foregroundColor: String
    let backgroundColor: String
}

extension SkillUseCaseModel {
    init(from jsonModel: SkillJsonModel) {
        self.title = jsonModel.title
        self.experienceInYears = jsonModel.experienceInYears
        self.iconAsset = jsonModel.iconAsset
        self.foregroundColor = jsonModel.foregroundColor
        self.backgroundColor = jsonModel.backgroundColor
    }
}
