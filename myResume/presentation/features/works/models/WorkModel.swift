//
//  WorkModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

struct WorkModel: Identifiable, Equatable {
    let id: UUID
    let title: String
    let company: String
    let location: String
}

extension WorkModel {
    init(from useCaseModel: WorkUseCaseModel) {
        self.id = UUID()
        self.title = useCaseModel.title
        self.company = useCaseModel.company
        self.location = useCaseModel.location
    }
}
