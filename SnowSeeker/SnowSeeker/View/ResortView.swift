//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 27/10/2022.
//

import SwiftUI

struct ResortView: View {

    let resort: Resort

    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.dynamicTypeSize) private var typeSize

    @EnvironmentObject private var favorites: Favorites

    @State private var selectedFacility: Facility?
    @State private var showingFacility = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()

                HStack {
                    details
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))

                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }

            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if favorites.contains(resort) {
                    favorites.remove(resort)
                } else {
                    favorites.add(resort)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            selectedFacility?.rawValue ?? "More information",
            isPresented: $showingFacility, presenting: selectedFacility
        ) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }

    @ViewBuilder
    private var details: some View {
        if sizeClass == .compact && typeSize > .large {
            VStack(spacing: 10) { ResortDetailsView(resort: resort) }
            VStack(spacing: 10) { SkiDetailsView(resort: resort) }
        } else {
            ResortDetailsView(resort: resort)
            SkiDetailsView(resort: resort)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.previewResort)
    }
}
