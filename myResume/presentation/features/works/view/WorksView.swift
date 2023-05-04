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
                    ForEach(viewModel.works) { work in
                        workCardView(work: work)
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
                await self.viewModel.load()
            }
        }
    }
    
    private func workCardView(work: WorkModel) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            .padding(.top, 6)
            
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(work.title)
                            .font(.title2.bold())
                        Text(work.company)
                            .font(.callout)
                            .foregroundStyle(.secondary)
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
            }
            .padding(0)
            .hLeading()
        }
        .hLeading()
    }
    
    private var toastMessage: some View {
        VStack {
            Spacer()
            if let errorMessage = viewModel.errorMessage {
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
                    self.viewModel.errorMessage = nil
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.viewModel.errorMessage = nil
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        .animation(.easeIn, value: (viewModel.errorMessage != nil))
        .transition(.slide)
    }
}

struct WorksView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WorksViewModelFactory.make()
        WorksView(viewModel: viewModel)
    }
}
