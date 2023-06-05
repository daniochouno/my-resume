//
//  WorkDetailsView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 17/5/23.
//

import SwiftUI

struct WorkDetailsView: View {
    @ObservedObject var viewModel: WorkDetailsViewModel
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 18) {
                    if self.viewModel.isLoading {
                        ProgressView()
                            .padding()
                    } else if let details = viewModel.workDetails {
                        
                        Text(LocalizedStringKey(details.title))
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        HStack {
                            AsyncImage(url: URL(string: details.companyLogoUrl)) { image in
                                image
                                    .resizable()
                                    .cornerRadius(18)
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 36, height: 36)
                            
                            Text(details.company)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }.padding(.horizontal)
                        
                        VStack(spacing: 4) {
                            Text("workDetails.timelapse \(details.startDate.formatted(.dateTime.month(.wide).year())) \(details.endDate?.formatted(.dateTime.month(.wide).year()) ?? String(localized: "workDetails.timelapse.current"))")
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if let (years, months) = viewModel.getTimelapseCount() {
                                Text("workDetails.timelapse.total \(String(years)) \(String(months))")
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }.padding(.horizontal)
                        
                        if let summary = details.summary {
                            Text("workDetails.summary")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            Text(LocalizedStringKey(summary))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        
                        if let goalsAchieved = details.goalsAchieved {
                            Text("workDetails.goalsAchieved")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            ForEach(goalsAchieved, id: \.self) { goal in
                                HStack(alignment: .top, spacing: 4) {
                                    Text("◦")
                                    Text(LocalizedStringKey(goal))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            }
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
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButtonView())
        .onAppear {
            Task {
                await self.viewModel.load()
            }
        }
    }
}

struct WorkDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WorkDetailsViewModelFactory.make(id: "axv0BMVwVnZha787kP0j")
        WorkDetailsView(viewModel: viewModel)
    }
}
