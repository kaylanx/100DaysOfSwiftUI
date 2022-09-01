//
//  PhotoDetailView.swift
//  PhotoNames
//
//  Created by Andy Kayley on 03/09/2022.
//

import SwiftUI

struct PhotoDetailView: View {

    let namedPhoto: NamedPhoto

    var body: some View {
        ZStack(alignment: .top) {
            CacheableAsyncImage(
                url: namedPhoto.imageUrl,
                placeholder: { ProgressView() },
                image: {
                    Image(uiImage: $0)
                        .resizable()
                }
            )
            .blur(radius: 20, opaque: true)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()

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
        .navigationTitle(namedPhoto.name)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(namedPhoto: PreviewNamedPhotos.namedPhotos.first!)
    }
}
