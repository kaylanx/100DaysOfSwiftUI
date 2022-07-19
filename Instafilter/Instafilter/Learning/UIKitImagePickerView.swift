//
//  UIKitImagePickerView.swift
//  Instafilter
//
//  Created by Andy Kayley on 19/07/2022.
//

import SwiftUI

struct UIKitImagePickerView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct UIKitImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        UIKitImagePickerView()
    }
}
