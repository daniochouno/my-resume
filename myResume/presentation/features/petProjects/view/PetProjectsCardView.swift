//
//  PetProjectsCardView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import SwiftUI

struct PetProjectsCardView: View {
    let petProject: PetProjectItemEntity
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack {
            ZStack {
                Color(hex: petProject.headerColor)
                    .frame(height: 96)
                
                AsyncImage(url: URL(string: petProject.iconUrl)) { phase in
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
                .offset(y: 36)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            
            VStack(spacing: 0) {
                if let downloads = petProject.downloads {
                    Text("petProjects.downloads.\(downloads)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                }
                
                Text(LocalizedStringKey(petProject.titleKey))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text(LocalizedStringKey(petProject.subtitleKey))
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 4)
                
                HStack(spacing: 12) {
                    if let linkAppStore = petProject.linkAppStore,
                       let url = URL(string: NSLocalizedString(linkAppStore, comment: "")) {
                        storeButton(.appStore, url: url)
                    }
                    if let linkPlayStore = petProject.linkPlayStore,
                       let url = URL(string: NSLocalizedString(linkPlayStore, comment: "")) {
                        storeButton(.googlePlay, url: url)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }
        .background(Color(.tertiarySystemFill))
        .cornerRadius(12)
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

struct PetProjectsCardView_Previews: PreviewProvider {
    static var previews: some View {
        let petProject = PetProjectItemEntity(
            id: UUID(),
            documentId: "abc",
            titleKey: "petProjects.myWardrobe.title",
            subtitleKey: "petProjects.myWardrobe.subtitle",
            iconUrl: "https://play-lh.googleusercontent.com/TJxlM5eKv-g0_lo7emIZb9FrWkgrk0EejfVsObOC97Z2hpbgOV4Fkp1b6Lu-HOPXf_k=w240-h480",
            headerColor: "#5E9C98",
            linkAppStore: "petProjects.myWardrobe.link.appStore",
            linkPlayStore: "petProjects.myWardrobe.link.playStore",
            linkWeb: "http://www.miarmarioapp.com",
            downloads: "100k"
        )
        PetProjectsCardView(petProject: petProject)
    }
}
