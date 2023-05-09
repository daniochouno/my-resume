//
//  SkillsViewControllerFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

enum SkillsViewControllerFactory {
    static func makeView() -> SkillsViewController {
        let viewModel = SkillsViewModelFactory.make()
        let viewController = SkillsViewController.instantiate()
        viewModel.output = viewController
        viewController.viewModel = viewModel
        return viewController
    }
}
