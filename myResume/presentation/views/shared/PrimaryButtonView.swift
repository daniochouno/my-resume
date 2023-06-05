//
//  PrimaryButtonView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 1/6/23.
//

import SwiftUI

struct PrimaryButtonView: View {
    let title: String
    let onTap: () -> ()
    
    init(title: String, onTap: @escaping () -> Void) {
        self.title = title
        self.onTap = onTap
    }
    
    var body: some View {
        Button(LocalizedStringKey(title)) {
            onTap()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .foregroundColor(.white)
        .background(Color("PrimaryColor"))
        .cornerRadius(.infinity)
    }
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonView(title: "Do now", onTap: { })
    }
}
