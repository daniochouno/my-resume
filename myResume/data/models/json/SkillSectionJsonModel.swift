//
//  SkillSectionJsonModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 8/5/23.
//

import Foundation

struct SkillSectionJsonModel: Decodable {
    let titleKey: String
    let order: Int
    let items: [SkillJsonModel]
}
