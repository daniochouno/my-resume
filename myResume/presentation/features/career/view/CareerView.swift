//
//  CareerView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 18/4/23.
//

import SwiftUI

struct CareerView: View {
    @State var tabIndex = 0
    
    var body: some View {
        NavigationView {
            VStack{
                TopTabBar(tabIndex: $tabIndex)
                
                ZStack {
                    if tabIndex == 0 {
                        WorksViewFactory.makeView()
                    } else {
                        PetProjectsViewFactory.makeView()
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
                .padding([.leading, .trailing])
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TopTabBar: View {
    @Binding var tabIndex: Int
    
    var body: some View {
        HStack(spacing: 12) {
            TabBarButton(text: "career.tabs.works.title", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            TabBarButton(text: "career.tabs.sideProjects.title", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
        }
        .frame(maxWidth: .infinity)
        .background(Color("PrimaryColor"))
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Text(LocalizedStringKey(text))
            .font(.title3)
            .foregroundColor(isSelected ? Color("PrimaryColor") : .white)
            .frame(height: 42)
            .padding(.horizontal)
            .background {
                if isSelected {
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
    }
}

struct CareerView_Previews: PreviewProvider {
    static var previews: some View {
        CareerView()
    }
}
