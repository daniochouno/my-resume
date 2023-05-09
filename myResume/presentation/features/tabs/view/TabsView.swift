//
//  TabsView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 14/4/23.
//

import SwiftUI

struct TabsView: View {
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
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
