//
//  PetProjectsView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import SwiftUI

struct PetProjectsView: View {
    @ObservedObject var presenter: PetProjectsPresenter
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 18) {
                    Text("petProjects.title")
                        .frame(width: .infinity, alignment: .leading)
                    
                    if self.presenter.isLoading {
                        ProgressView()
                    } else {
                        ForEach(presenter.petProjects) { petProject in
                            PetProjectsCardView(petProject: petProject)
                        }
                    }
                }
                .padding(4)
                .padding(.top, 4)
            }
            .padding()
            
            toastMessage
        }
        .onAppear {
            Task {
                await self.presenter.onViewAppear()
            }
        }
    }
    
    private var toastMessage: some View {
        VStack {
            Spacer()
            if let errorMessage = presenter.errorMessage {
                Group {
                    Text(errorMessage)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.black)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(4)
                .onTapGesture {
                    self.presenter.errorMessage = nil
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.presenter.errorMessage = nil
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        .animation(.easeIn, value: (presenter.errorMessage != nil))
        .transition(.slide)
    }
}

struct PetProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = PetProjectsPresenterFactory.make()
        PetProjectsView(presenter: presenter)
    }
}
