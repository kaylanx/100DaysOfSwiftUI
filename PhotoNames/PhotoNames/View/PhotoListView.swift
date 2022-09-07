//
//  PhotoList.swift
//  PhotoNames
//
//  Created by Andy Kayley on 10/08/2022.
//

import SwiftUI

struct PhotoListView: View {

    @StateObject var viewModel: ViewModel

    @State private var isShowingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var imageName: String = ""

    var body: some View {
        ZStack(alignment: .center) {
            List {
                ForEach(viewModel.namedPhotos) { photo in
                    NavigationLink(
                        destination: PhotoDetailView(namedPhoto: photo)
                    ) {
                        cell(for: photo)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Photo Names")
            .sheet(isPresented: $isShowingImagePicker) {
                addImageView()
            }
            .toolbar {
                Button {
                    isShowingImagePicker.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    func cell(for photo: NamedPhoto) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(photo.name)
            }
            Spacer()
            CacheableAsyncImage(
                url: photo.imageUrl,
                placeholder: {
                    ProgressView()
                },
                image: {
                    Image(uiImage: $0)
                        .resizable()
                }
            )
            .frame(maxWidth: 50, maxHeight: 50)
        }
    }

    func delete(at offsets: IndexSet) {
        viewModel.delete(at: offsets)
    }

    @ViewBuilder
    private func addImageView() -> some View {
        if inputImage != nil {
            PhotoNameView(
                photoName: $imageName
            ) {
                viewModel.save(
                    image: inputImage,
                    imageName: imageName
                )
                resetState()
            }
        } else {
            ImagePicker(
                image: $inputImage
            )
        }
    }

    private func resetState() {
        isShowingImagePicker = false
        inputImage = nil
        imageName = ""
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(
            viewModel: PhotoListView.ViewModel(photoStorageService: PreviewPhotoStorageService())
        )
    }
}
