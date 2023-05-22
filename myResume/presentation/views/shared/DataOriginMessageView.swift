//
//  DataOriginMessageView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 18/5/23.
//

import SwiftUI

struct DataOriginMessageView: View {
    let message: String?
    
    var body: some View {
        if let message {
            Text(LocalizedStringKey(message))
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
        }
    }
}

struct DataOriginMessageView_Previews: PreviewProvider {
    static var previews: some View {
        DataOriginMessageView(message: "Estos datos se han cargado de la caché local")
    }
}
