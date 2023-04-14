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
            Text("tabs.experience.title")
                .tabItem {
                    Label("tabs.experience.title", systemImage: "suitcase")
                }
            Text("tabs.skills.title")
                .tabItem {
                    Label("tabs.skills.title", systemImage: "studentdesk")
                }
            Text("tabs.aboutMe.title")
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
