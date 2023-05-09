//
//  AboutMeView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        ScrollView {
            Text("aboutMe.hello")
            
            Text("aboutMe.aboutThisProject.title")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
            
            Text("aboutMe.aboutThisProject.text")
                .padding(.bottom, 44)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.leading, .top, .trailing], 24)
    }
}

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeView()
    }
}
