//
//  PetProjectDetailsView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 23/5/23.
//

import SwiftUI

struct PetProjectDetailsView: View {
    @ObservedObject var viewModel: PetProjectDetailsViewModel
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack {
            VStack {
                if self.viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let details = viewModel.petProjectDetails {
                    ZStack {
                        Color(hex: details.headerColor)
                            .frame(height: 120)
                        
                        AsyncImage(url: URL(string: details.iconUrl)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 96, height: 96)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .stroke(.white, lineWidth: 4)
                        )
                        .offset(y: 60)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    
                    VStack(spacing: 0) {
                        if let downloads = details.downloads {
                            Text("petProjects.downloads.\(downloads)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding()
                        }
                        
                        Text(LocalizedStringKey(details.titleKey))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        Text(LocalizedStringKey(details.subtitleKey))
                            .font(.body)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top, 4)
                        
                        HStack(spacing: 12) {
                            if let linkAppStore = details.linkAppStore {
                                storeButton(.appStore, url: URL(string: linkAppStore)!)
                            }
                            if let linkPlayStore = details.linkPlayStore {
                                storeButton(.googlePlay, url: URL(string: linkPlayStore)!)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        
                        DataOriginMessageView(message: viewModel.dataLoadedOrigin)
                            .padding()
                        
                        Spacer()
                    }
                }
            }
            
            ErrorMessageView(message: viewModel.errorMessage) {
                self.viewModel.errorMessage = nil
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
        .onAppear {
            Task {
                await self.viewModel.load()
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            self.dismiss()
        }) {
            Label(title: {
                Text(LocalizedStringKey("navigation.back"))
            }, icon: {
                Image(systemName: "arrow.left")
            })
            .foregroundColor(.black)
        }
        .labelStyle(.titleAndIcon)
    }
    
    private func storeButton(_ style: PetProjectsAppStoreType, url: URL) -> some View {
        Button {
            openURL(url)
        } label: {
            Label {
                Text(LocalizedStringKey(String("petProjects.stores.\(style.rawValue)")))
                    .font(.footnote)
            } icon: {
                Image(style.rawValue)
                    .resizable()
                    .padding(2)
                    .frame(width: 20, height: 20)
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            .background(.black)
            .cornerRadius(16)
        }
        .foregroundColor(.white)
    }
    
    enum PetProjectsAppStoreType: String {
        case appStore
        case googlePlay
    }
}

struct PetProjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PetProjectDetailsViewModelFactory.make(id: "KIt9AehQ9hVTNl66fSvP")
        PetProjectDetailsView(viewModel: viewModel)
    }
}
