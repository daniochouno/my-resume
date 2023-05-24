//
//  PetProjectsRouter.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 24/5/23.
//

import SwiftUI

struct PetProjectsRouter {
    func details(id: String) -> some View {
        PetProjectDetailsViewFactory.makeView(id: id)
    }
}
