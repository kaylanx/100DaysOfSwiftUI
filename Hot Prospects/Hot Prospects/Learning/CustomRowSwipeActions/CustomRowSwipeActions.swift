//
//  CustomRowSwipeActions.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 13/09/2022.
//

import SwiftUI

enum CustomRowSwipeActions {

    struct ContentView: View {
        var body: some View {
            List {
                Text("Taylor Swift")
                    .swipeActions {
                        Button(role: .destructive) {
                            print("Hi")
                        } label: {
                            Label("Delete", systemImage: "minus.circle")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            print("Hi")
                        } label: {
                            Label("Pin", systemImage: "pin")
                        }
                        .tint(.orange)
                    }
            }
        }
    }
}

