//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 26/10/2022.
//

import SwiftUI

enum SortBy: String, CaseIterable {
    case `default` = "Default"
    case alphabetical = "Alphabetical"
    case country = "Country"
}

extension Array where Element == Resort {
    func sorted(by sortBy: SortBy) -> [Resort] {
        switch sortBy {
            case .default:
                return self.sorted { lhs, rhs in
                    lhs.order < rhs.order
                }
            case .alphabetical:
                return self.sorted { lhs, rhs in
                    lhs.name < rhs.name
                }
            case .country:
                return self.sorted { lhs, rhs in
                    lhs.country < rhs.country
                }
        }
    }
}

struct ContentView: View {

    @StateObject var favorites = Favorites()

    @State private var searchText = ""

    let resorts: [Resort] = ContentView.loadData()

    private var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
                .sorted(by: sortBy)
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                .sorted(by: sortBy)
        }
    }

    @State private var sortBy = SortBy.default

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu {
                    Picker("Choose a sort order", selection: $sortBy) {
                        ForEach(SortBy.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }


            WelcomeView()
        }
        .environmentObject(favorites)
    }

    private static func loadData() -> [Resort] {
        var order = 0
        let resorts: [Resort] = Bundle.main.decode("resorts.json")
        return resorts.map {
            let resort = Resort.resort($0, withOrder: order)
            order += 1
            return resort
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
