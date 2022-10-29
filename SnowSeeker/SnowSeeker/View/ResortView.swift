//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 27/10/2022.
//

import SwiftUI

struct ResortView: View {

    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize

    let resort: Resort

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

                    Text(resort.facilities, format: .list(type: .and))
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
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
