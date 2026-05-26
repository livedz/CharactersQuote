//
//  BB_QuotesApp.swift
//  BB Quotes
//
//  Created by MOKSHA on 10/03/26.
//

import SwiftUI

@main
struct BB_QuotesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView(tabViewList: [TabDetails(type: .breakingBad),
                                  TabDetails(type: .betterCallSaul),
                                  TabDetails(type: .elCamino)])
            }
        }
    }
}
