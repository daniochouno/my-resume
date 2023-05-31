//
//  SplashView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 31/5/23.
//

import SwiftUI

struct SplashView: View {
    @Binding var isSplashBeingDisplayed: Bool
    
    @ObservedObject var viewModel: SplashViewModel
    
    @State private var isFirstAnimationEnabled: Bool = false
    @State private var isSecondAnimationEnabled: Bool = false
    
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color("SplashViewBackground")
                .edgesIgnoringSafeArea(.all)
            
            Image(systemName: "case.fill")
                .font(.system(size: 64))
                .foregroundColor(.white)
                .scaleEffect(isFirstAnimationEnabled ? 0.6 : 1)
                .scaleEffect(isSecondAnimationEnabled ? UIScreen.main.bounds.size.height/4 : 1)
        }
        .onReceive(timer) { input in
            switch viewModel.animationPhase {
            case .first:
                withAnimation(.spring()) {
                    isFirstAnimationEnabled.toggle()
                }
            case .second:
                withAnimation(.easeOut(duration: 1.2)) {
                    isSecondAnimationEnabled = true
                }
            case .finished:
                isSplashBeingDisplayed = false
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                viewModel.goToSecondPhase()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                viewModel.finish()
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let isSplashBeingDisplayed: Binding<Bool> = Binding<Bool>(
            get: { true },
            set: { _ = $0 }
        )
        let viewModel = SplashViewModelFactory.make()
        SplashView(isSplashBeingDisplayed: isSplashBeingDisplayed, viewModel: viewModel)
    }
}
