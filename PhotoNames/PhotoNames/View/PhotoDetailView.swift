//
//  PhotoDetailView.swift
//  PhotoNames
//
//  Created by Andy Kayley on 03/09/2022.
//

import SwiftUI

struct PhotoDetailView: View {

    @State private var selectedSegment = 0
    let namedPhoto: NamedPhoto

    var body: some View {
        VStack {
            segmentedControl
            mainView
            Spacer()
        }
        .navigationTitle(namedPhoto.name)
    }

    private var segmentedControl: some View {
        Picker("", selection: $selectedSegment) {
            Text("Photo").tag(0)
            Text("Location").tag(1)
        }
        .pickerStyle(.segmented)
    }

    private var mainView: some View {
        ZStack {
            if selectedSegment == 0 {
                photo
            } else {
                mapView
            }
        }
    }

    private var photo: some View {
        CacheableAsyncImage(
            url: namedPhoto.imageUrl,
            placeholder: { ProgressView() },
            image: {
                Image(uiImage: $0)
                    .resizable()
            }
        )
        .aspectRatio(contentMode: .fit)
        .padding()
    }

    @ViewBuilder
    private var mapView: some View {
        if let location = namedPhoto.location {
            PhotoLocationView(location: location)
        } else {
            Text("No location stored for this photo")
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(namedPhoto: PreviewNamedPhotos.namedPhotos.first!)
    }
}
