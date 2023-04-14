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
            Text("Experiencia")
                .tabItem {
                    Label("Experiencia", systemImage: "suitcase")
                }
            Text("Formación")
                .tabItem {
                    Label("Formación", systemImage: "studentdesk")
                }
            Text("Sobre mí")
                .tabItem {
                    Label("Sobre mí", systemImage: "person.circle")
                }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
