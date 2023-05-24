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
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if self.presenter.isLoading {
                        ProgressView()
                    } else {
                        ForEach(presenter.petProjects) { petProject in
                            NavigationLink {
                                presenter.detailsView(id: petProject.documentId)
                            } label: {
                                PetProjectsCardView(petProject: petProject)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        DataOriginMessageView(message: presenter.dataLoadedOrigin)
                    }
                }
                .padding(4)
                .padding(.top, 4)
            }
            .padding()
            
            ErrorMessageView(message: presenter.errorMessage) {
                self.presenter.errorMessage = nil
            }
        }
        .onAppear {
            Task {
                await self.presenter.onViewAppear()
            }
        }
    }
}

struct PetProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = PetProjectsPresenterFactory.make()
        PetProjectsView(presenter: presenter)
    }
}
