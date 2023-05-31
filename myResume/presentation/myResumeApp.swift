//
//  my_resumeApp.swift
//  my-resume
//
//  Created by Daniel Martínez Muñoz on 11/4/23.
//

import SwiftUI

@main
struct myResumeApp: App {
    @State var isSplashBeingDisplayed = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabsViewFactory.makeView()
                
                if isSplashBeingDisplayed {
                    SplashViewFactory.makeView(isSplashBeingDisplayed: $isSplashBeingDisplayed)
                }
            }
        }
    }
}
