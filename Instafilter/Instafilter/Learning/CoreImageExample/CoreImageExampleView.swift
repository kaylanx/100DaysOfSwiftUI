//
//  CoreImageExampleView.swift
//  Instafilter
//
//  Created by Andy Kayley on 18/07/2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

enum EffectType: String, CaseIterable, Equatable {
    case pixellate
    case sepiaTone
    case crystallize
    case twirlDistortion1
    case twirlDistortion2

    func filter(for inputImage: UIImage, beginImage: CIImage?) -> CIFilter {
        switch self {
            case .pixellate:
                return pixellate(beginImage: beginImage)
            case .sepiaTone:
                return sepiaTone(beginImage: beginImage)
            case .crystallize:
                return crystallize(beginImage: beginImage)
            case .twirlDistortion1:
                return twirlDistortion1(beginImage: beginImage, inputImage: inputImage)
            case .twirlDistortion2:
                return twirlDistortion2(beginImage: beginImage)
        }
    }

    private func pixellate(beginImage: CIImage?) -> CIFilter {
        let currentFilter = CIFilter.pixellate()
        currentFilter.inputImage = beginImage
        currentFilter.scale = 100
        return currentFilter
    }

    private func sepiaTone(beginImage: CIImage?) -> CIFilter {
        let currentFilter = CIFilter.sepiaTone()

        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        return currentFilter
    }

    private func crystallize(beginImage: CIImage?) -> CIFilter {
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        currentFilter.radius = 200
        return currentFilter
    }

    private func twirlDistortion1(beginImage: CIImage?, inputImage: UIImage) -> CIFilter {
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage
        currentFilter.radius = 1000
        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
        return currentFilter
    }

    private func twirlDistortion2(beginImage: CIImage?) -> CIFilter {
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage

        let amount = 1.0

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        return currentFilter
    }
}

struct CoreImageExampleView: View {

    @State private var image: Image?
    @State private var effectType: EffectType = .pixellate
    @State private var showingImagePicker = false


    var body: some View {
        VStack {
            Picker("Pick a filter", selection: $effectType) {
                ForEach(EffectType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .onChange(of: effectType) { _ in
                loadImage()
            }

            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                showingImagePicker = true
            }
        }
        .onAppear(perform: loadImage)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }

    func loadImage() {
        guard let inputImage = UIImage(named: "example") else { return }

        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        let currentFilter = effectType.filter(for: inputImage, beginImage: beginImage)

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImageExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageExampleView()
    }
}
