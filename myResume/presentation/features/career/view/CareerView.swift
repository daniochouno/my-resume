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
        VStack{
            TopTabBar(tabIndex: $tabIndex)
                .padding(.bottom)
            if tabIndex == 0 {
                WorksViewFactory.makeView()
            }
            else {
                PetProjectsViewFactory.makeView()
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
        .padding([.top, .leading, .trailing])
    }
}

struct TopTabBar: View {
    @Binding var tabIndex: Int
    
    var body: some View {
        HStack(spacing: 20) {
            TabBarButton(text: "career.tabs.works.title", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            TabBarButton(text: "career.tabs.sideProjects.title", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            Spacer()
        }
        .border(width: 1, edges: [.bottom], color: .black)
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
            .fontWeight(isSelected ? .heavy : .regular)
            .padding(.bottom, 10)
            .border(width: isSelected ? 4 : 1, edges: [.bottom], color: .black)
    }
}

struct CareerView_Previews: PreviewProvider {
    static var previews: some View {
        CareerView()
    }
}
