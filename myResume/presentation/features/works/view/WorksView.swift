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
            List(viewModel.works) { work in
                Text(work.title)
            }
            toastMessage
        }
        .onAppear {
            Task {
                await self.viewModel.load()
            }
        }
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
