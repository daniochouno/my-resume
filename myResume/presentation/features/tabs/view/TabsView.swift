//
//  TabsView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 14/4/23.
//

import SwiftUI

struct TabsView: View {
    @ObservedObject var viewModel: TabsViewModel
    
    var body: some View {
        TabView {
            CareerViewFactory.makeView()
                .tabItem {
                    Label("tabs.experience.title", systemImage: "suitcase")
                }
            SkillsViewFactory.makeView()
                .tabItem {
                    Label("tabs.skills.title", systemImage: "studentdesk")
                }
            AboutMeViewFactory.makeView()
                .tabItem {
                    Label("tabs.aboutMe.title", systemImage: "person.circle")
                }
        }
        .onAppear {
            Task {
                self.viewModel.initializeSettingsBundle()
            }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TabsViewModelFactory.make()
        TabsView(viewModel: viewModel)
    }
}
