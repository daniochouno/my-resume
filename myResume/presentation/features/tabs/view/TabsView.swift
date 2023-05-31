//
//  TabsView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 14/4/23.
//

import SwiftUI

struct TabsView: View {
    @ObservedObject var viewModel: TabsViewModel
    @State private var activeTab: Tab = .career
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                switch activeTab {
                case .career:
                    CareerViewFactory.makeView()
                case .skills:
                    SkillsViewFactory.makeView()
                case .aboutMe:
                    AboutMeViewFactory.makeView()
                }
            }
            
            CustomTabBar()
        }
        .onAppear {
            UITabBar.appearance().isHidden = true
            
            Task {
                self.viewModel.initializeSettingsBundle()
            }
        }
    }
    
    @ViewBuilder
    private func CustomTabBar(
        tint: Color = Color("PrimaryColor"),
        inactiveTint: Color = .gray
    ) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab
                )
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 20)
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
    
    private struct TabItem: View {
        var tint: Color
        var inactiveTint: Color
        var tab: Tab
        var animation: Namespace.ID
        @Binding var activeTab: Tab
        
        var body: some View {
            VStack(spacing: 5) {
                Image(systemName: tab.systemImage)
                    .font(.title2)
                    .foregroundColor(activeTab == tab ? .white : inactiveTint)
                    .frame(width: activeTab == tab ? 58 : 32, height: activeTab == tab ? 58 : 32)
                    .background {
                        if activeTab == tab {
                            Circle()
                                .fill(tint)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                
                Text(LocalizedStringKey(tab.rawValue))
                    .font(.caption)
                    .foregroundColor(activeTab == tab ? tint : inactiveTint)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                activeTab = tab
            }
        }
    }
}

enum Tab: String, CaseIterable {
    case career = "tabs.experience.title"
    case skills = "tabs.skills.title"
    case aboutMe = "tabs.aboutMe.title"
    
    var systemImage: String {
        switch self {
        case .career:
            return "suitcase"
        case .skills:
            return "studentdesk"
        case .aboutMe:
            return "person.circle"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TabsViewModelFactory.make()
        TabsView(viewModel: viewModel)
    }
}
