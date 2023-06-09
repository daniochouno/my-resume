//
//  StoreButtonView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/6/23.
//

import SwiftUI

struct StoreButtonView: View {
    @Environment(\.openURL) private var openURL
    
    let type: StoreButtonType
    let url: URL
    
    init(type: StoreButtonType, url: URL) {
        self.type = type
        self.url = url
    }
    
    var body: some View {
        Button {
            openURL(self.url)
        } label: {
            Label {
                Text(LocalizedStringKey(String("petProjects.stores.\(type.rawValue)")))
                    .font(.footnote)
            } icon: {
                Image(type.rawValue)
                    .resizable()
                    .padding(2)
                    .frame(width: 20, height: 20)
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            .background(Color("PrimaryColor"))
            .cornerRadius(16)
        }
        .foregroundColor(.white)
    }
}

enum StoreButtonType: String {
    case appStore
    case googlePlay
}

struct StoreButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let type: StoreButtonType = .appStore
        let url = URL(string: "https://www.google.es")!
        StoreButtonView(type: type, url: url)
    }
}
