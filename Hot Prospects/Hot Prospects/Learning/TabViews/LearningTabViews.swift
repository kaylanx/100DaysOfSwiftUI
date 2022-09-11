//
//  LearningTabViews.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 11/09/2022.
//

import SwiftUI

enum LearningTabViews {

    struct ContentView: View {

        enum TabTags: String {
            case one = "One"
            case two = "Two"
        }

        @State private var selectedTab = TabTags.one

        var body: some View {
            TabView(selection: $selectedTab) {
                Text("Tab 1")
                    .onTapGesture {
                        selectedTab = .two
                    }
                    .tabItem {
                        Label("One", systemImage: "star")
                    }
                    .tag(TabTags.one)
                Text("Tab 2")
                    .tabItem {
                        Label("Two", systemImage: "circle")
                    }
                    .tag(TabTags.two)
            }
        }
    }

}
