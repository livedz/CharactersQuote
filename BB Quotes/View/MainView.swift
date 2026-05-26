//
//  MainView.swift
//  BB Quotes
//
//  Created by MOKSHA on 10/03/26.
//
import SwiftUI

struct MainView: View {
    var tabViewList = [TabDetails]()
    var body: some View {
        TabView {
            ForEach(tabViewList) { tab in
                Tab(tab.getTitle(),systemImage: tab.getImage()) {
                    FetchView(showType: tab)
                }
            }
        }
        .tabViewStyle(.tabBarOnly)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainView(tabViewList: [TabDetails(type: .breakingBad),
                           TabDetails(type: .betterCallSaul),
                           TabDetails(type: .elCamino)])
}
