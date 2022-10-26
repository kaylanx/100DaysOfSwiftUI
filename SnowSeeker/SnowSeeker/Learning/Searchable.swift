//
//  Searchable.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 26/10/2022.
//

import SwiftUI

enum Searchable {
    struct ContentView: View {
        @State private var searchText = ""

        var body: some View {
            NavigationView {
                Text("Searching for \(searchText)")
                    .searchable(text: $searchText, prompt: "Look for something")
                    .navigationTitle("Searching")
            }
        }
    }

    struct ContentView2: View {
        @State private var searchText = ""
        let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

        var body: some View {
            NavigationView {
                List(filteredNames, id: \.self) { name in
                    Text(name)
                }
                .searchable(text: $searchText, prompt: "Look for something")
                .navigationTitle("Searching")
            }
        }

        var filteredNames: [String] {
            if searchText.isEmpty {
                return allNames
            } else {
                return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            ContentView2()

        }
    }

}
