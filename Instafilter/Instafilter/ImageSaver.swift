//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Andy Kayley on 19/07/2022.
//

import SwiftUI

class ImageSaver: NSObject {

    private var successHandler: (() -> Void)?
    private var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage, successHandler: (() -> Void)?, errorHandler: ((Error) -> Void)?) {
        self.successHandler = successHandler
        self.errorHandler = errorHandler
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
