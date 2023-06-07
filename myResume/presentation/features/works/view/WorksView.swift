//
//  WorksView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import SwiftUI

struct WorksView: View {
    @ObservedObject var viewModel: WorksViewModel
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 18) {
                    if self.viewModel.isLoading {
                        ProgressView()
                    } else {
                        ForEach(viewModel.works) { work in
                            NavigationLink {
                                WorkDetailsViewFactory.makeView(id: work.documentId)
                            } label: {
                                workCardView(work: work)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        DataOriginMessageView(message: viewModel.dataLoadedOrigin)
                    }
                }
                .padding(4)
                .padding(.top, 4)
            }
            .padding()
            
            ErrorMessageView(message: viewModel.errorMessage) {
                self.viewModel.errorMessage = nil
            }
        }
        .onAppear {
            Task {
                await self.viewModel.load()
            }
        }
    }
    
    private func workCardView(work: WorkModel) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack(spacing: 10) {
                AsyncImage(url: URL(string: work.companyLogoUrl)) { image in
                    image
                        .resizable()
                        .cornerRadius(18)
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 36, height: 36)
                
                Rectangle()
                    .fill(Color("Black"))
                    .frame(width: 3)
            }
            .padding(.top, 6)
            
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(LocalizedStringKey(work.titleKey))
                            .font(.title2.bold())
                        
                        Text(LocalizedStringKey(work.companyKey))
                            .font(.callout)
                        
                        HStack(spacing: 4) {
                            Text(work.startDate.formatted(.dateTime.month().year()))
                                .font(.callout)
                                .foregroundStyle(.secondary)
                            Text("-")
                                .foregroundStyle(.secondary)
                            Text(work.endDate?.formatted(.dateTime.month().year()) ?? String(localized: "works.timelapse.current"))
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .hLeading()
                }
                .padding(.top, 8)
            }
            .padding(0)
            .hLeading()
        }
        .hLeading()
    }
}

struct WorksView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WorksViewModelFactory.make()
        WorksView(viewModel: viewModel)
    }
}
