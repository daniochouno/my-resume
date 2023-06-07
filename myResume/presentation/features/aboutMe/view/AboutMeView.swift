//
//  AboutMeView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import SwiftUI

struct AboutMeView: View {
    @State var isPdfViewerActive = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("aboutMe.hello.title")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("aboutMe.hello.text")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                
                Text("aboutMe.aboutThisProject.title")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                
                Text("aboutMe.aboutThisProject.text")
                    .padding(.bottom, 44)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: PDFViewerView(), isActive: $isPdfViewerActive) {
                        PrimaryButtonView(title: "aboutMe.resume.pdf") {
                            isPdfViewerActive = true
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .top, .trailing], 24)
        }
    }
}

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeView()
    }
}
