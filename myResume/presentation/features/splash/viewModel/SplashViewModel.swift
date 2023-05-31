//
//  SplashViewModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 31/5/23.
//

import Foundation

final class SplashViewModel: ObservableObject {
    var animationPhase: AnimationPhase = .first
    
    func goToSecondPhase() {
        animationPhase = .second
    }
    
    func finish() {
        animationPhase = .finished
    }
}

enum AnimationPhase {
    case first
    case second
    case finished
}
