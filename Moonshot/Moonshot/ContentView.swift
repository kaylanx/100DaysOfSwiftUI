//
//  ContentView.swift
//  Moonshot
//
//  Created by Andy Kayley on 11/05/2022.
//

import SwiftUI

struct ContentView: View {

    @State private var showingGrid = true

    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                if showingGrid {
                    LazyVGrid(columns: columns) {
                        MissionsView(
                            missions: missions,
                            astronauts: astronauts
                        )
                    }
                    .padding([.horizontal, .bottom])
                } else {
                    LazyVStack {
                        MissionsView(
                            missions: missions,
                            astronauts: astronauts
                        )
                    }
                    .padding([.horizontal, .bottom])
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    withAnimation {
                        showingGrid.toggle()
                    }
                } label: {
                    Image(systemName: showingGrid ? "rectangle.grid.1x2" : "rectangle.grid.2x2")
                }
                .foregroundColor(.lightBackground)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
