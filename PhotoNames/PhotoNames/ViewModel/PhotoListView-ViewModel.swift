//
//  PhotoListView-ViewModel.swift
//  PhotoNames
//
//  Created by Andy Kayley on 30/08/2022.
//

import SwiftUI

extension PhotoListView {
    class ViewModel: ObservableObject {

        private let photoStorageService: PhotoStorageService
        @Published var namedPhotos: [NamedPhoto]

        init(photoStorageService: PhotoStorageService = FileBasedPhotoStorageService()) {
            self.photoStorageService = photoStorageService
            namedPhotos = photoStorageService.loadPhotos().sorted()
        }

        func save(image: UIImage?, imageName: String) {

            let namedPhoto = NamedPhoto(name: imageName)

            if let jpegData = image?.jpegData(compressionQuality: 0.8) {
                photoStorageService.save(photo: jpegData, to: namedPhoto.imageUrl)
            }

            namedPhotos.append(namedPhoto)
            namedPhotos = namedPhotos.sorted()
            photoStorageService.save(photos: namedPhotos)
        }

        func delete(at offsets: IndexSet) {
            let namedPhotosToDelete = offsets.map { self.namedPhotos[$0] }
            namedPhotos.remove(atOffsets: offsets)
            photoStorageService.delete(photos: namedPhotosToDelete)
            photoStorageService.save(photos: namedPhotos)
        }
    }
}
