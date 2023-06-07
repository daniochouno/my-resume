//
//  SkillUseCaseModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

struct SkillUseCaseModel: Decodable {
    let title: String
    let iconAsset: String
}

extension SkillUseCaseModel {
    init(from jsonModel: SkillJsonModel) {
        self.title = jsonModel.title
        self.iconAsset = jsonModel.iconAsset
    }
}
