//
//  BackButtonView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 1/6/23.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: {
            self.dismiss()
        }) {
            Label(title: {
                Text(LocalizedStringKey("navigation.back"))
            }, icon: {
                Image(systemName: "arrow.left")
            })
            .foregroundColor(Color("AccentColor"))
        }
        .labelStyle(.titleAndIcon)
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
