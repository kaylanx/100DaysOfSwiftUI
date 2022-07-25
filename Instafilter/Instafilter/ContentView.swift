//
//  ContentView.swift
//  Instafilter
//
//  Created by Andy Kayley on 17/07/2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {

    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5

    @State private var isShowingImagePicker = false
    @State private var inputImage: UIImage?

    @State private var isShowingFilterSheet = false

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    private let context = CIContext()
    @State private var processedImage: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    isShowingImagePicker = true
                }

                if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { _ in
                                applyProcessing()
                            }
                    }
                }

                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius) { _ in
                                applyProcessing()
                            }
                    }
                }

                if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale)
                            .onChange(of: filterScale) { _ in
                                applyProcessing()
                            }
                    }
                }

                HStack {
                    Button("Change Filter") {
                        isShowingFilterSheet = true
                    }
                    Spacer()
                    Button("Save", action: save)
                        .disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in
                loadImage()
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $isShowingFilterSheet) {
                Group {
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                    Button("Thermal") { setFilter(CIFilter.thermal()) }
                    Button("X-Ray") { setFilter(CIFilter.xRay()) }
                    Button("Dither") { setFilter(CIFilter.dither()) }
                }

                Button("Cancel", role: .cancel) { }
            }
        }
    }

    private func loadImage() {
        guard let inputImage = inputImage else {
            return
        }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    private func save() {
        guard let processedImage = processedImage else {
            return
        }

        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: processedImage) {
            print("Success!")
        } errorHandler: { error in
            print("Oops: \(error.localizedDescription)")
        }
    }

    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
