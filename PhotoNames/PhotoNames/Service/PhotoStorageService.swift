//
//  PhotoStorageService.swift
//  PhotoNames
//
//  Created by Andy Kayley on 01/09/2022.
//

import Foundation

protocol PhotoStorageService {
    func save(photo: Data, to file: URL)
    func save(photos: [NamedPhoto])
    func loadPhotos() -> [NamedPhoto]
    func delete(photos: [NamedPhoto]) 
}

struct FileBasedPhotoStorageService: PhotoStorageService {

    private let fileName = "photos.json"

    func save(photo: Data, to file: URL) {
        try? photo.write(to: file, options: [.atomic, .completeFileProtection])
    }

    func save(photos: [NamedPhoto]) {
        do {
            try FileManager.encode(value: photos, to: fileName)
        } catch {
            // TODO: Better error handling
            print(error.localizedDescription)
        }
    }

    func loadPhotos() -> [NamedPhoto] {
        do {
            return try FileManager.decode(fileName)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func delete(photos: [NamedPhoto]) {
        let fileManager = FileManager()
        photos.forEach { photo in
            do {
                try fileManager.removeItem(at: photo.imageUrl)
            } catch {
                print(error)
            }
        }
    }
}
