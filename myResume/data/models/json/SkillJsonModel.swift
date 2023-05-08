//
//  SkillJsonModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

struct SkillJsonModel: Decodable {
    let title: String
    let experienceInYears: Int
    let iconAsset: String
    let foregroundColor: String
    let backgroundColor: String
}
