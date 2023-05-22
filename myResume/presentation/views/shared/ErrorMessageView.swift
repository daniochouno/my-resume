//
//  ErrorMessageView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 17/5/23.
//

import SwiftUI

struct ErrorMessageView: View {
    let message: String?
    let onClose: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            if let errorMessage = message {
                Group {
                    Text(LocalizedStringKey(errorMessage))
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(8)
                .onTapGesture {
                    self.onClose()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.onClose()
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        .animation(.easeIn, value: (message != nil))
        .transition(.slide)
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView(message: "Ha ocurrido un error", onClose: {
            
        })
    }
}
