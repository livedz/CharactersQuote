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
                Tab(tab.name,systemImage: tab.image) {
                    QuoteView(show: tab.name)
                }
            }
        }
        .tabViewStyle(.tabBarOnly)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainView(tabViewList: [TabDetails(name: "Breaking Bad", image: "tortoise"),
                      TabDetails(name: "Better Call Saul", image: "briefcase")])
}
