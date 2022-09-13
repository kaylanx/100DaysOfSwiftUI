//
//  CreatingContextMenus.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 13/09/2022.
//

import SwiftUI

enum CreatingContextMenus {


    struct ContentView: View {

        @State private var backgroundColor = Color.red

        var body: some View {
            VStack {
                Text("Hello, world!")
                    .padding()
                    .background(backgroundColor)

                Text("Change Color")
                    .padding()
                    .contextMenu {
                        Button(role: .destructive) {
                            backgroundColor = .red
                        } label: {
                            Label("Red", systemImage: "checkmark.circle.fill")
                        }

                        Button("Green") {
                            backgroundColor = .green
                        }

                        Button("Blue") {
                            backgroundColor = .blue
                        }
                    }
            }
        }
    }
}
