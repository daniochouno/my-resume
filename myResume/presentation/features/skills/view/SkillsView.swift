//
//  SkillsView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import SwiftUI

struct SkillsView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SkillsViewController
    
    func makeUIViewController(context: Context) -> SkillsViewController {
        return SkillsViewControllerFactory.makeView()
    }
    
    func updateUIViewController(_ uiViewController: SkillsViewController, context: Context) {
        
    }
}

struct SkillsView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsView()
    }
}
