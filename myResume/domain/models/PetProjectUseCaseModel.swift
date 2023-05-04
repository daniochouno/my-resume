//
//  PetProjectUseCaseModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import Foundation

struct PetProjectUseCaseModel: Decodable {
    let titleKey: String
    let subtitleKey: String
    let iconUrl: String
    let linkAppStore: String?
    let linkPlayStore: String?
    let linkWeb: String?
    let downloads: String?
}
