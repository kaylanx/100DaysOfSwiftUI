//
//  PreviewPhotoStorageService.swift
//  PhotoNames
//
//  Created by Andy Kayley on 01/09/2022.
//

import Foundation

struct PreviewPhotoStorageService: PhotoStorageService {
    func save(photo: Data, to file: URL) {
        // Do nothing
    }

    func save(photos: [NamedPhoto]) {
        // Do nothing
    }

    func loadPhotos() -> [NamedPhoto] {
        PreviewNamedPhotos.namedPhotos
    }

    func delete(photos: [NamedPhoto]) {
        // Do nothing
    }
}
