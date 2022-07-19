//
//  BlurringView.swift
//  Instafilter
//
//  Created by Andy Kayley on 17/07/2022.
//

import SwiftUI

struct BluringView: View {

    // Won't work for bindings because the state object
    // doesn't get changed just the binding directly.
//    @State private var blurAmount = 0.0 {
//        didSet {
//            print("New value is \(blurAmount)")
//        }
//    }

    @State private var blurAmount = 0.0

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)


            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { newValue in
                    print("New value is \(blurAmount)")
                }

            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

struct BlurringView_Previews: PreviewProvider {
    static var previews: some View {
        BluringView()
    }
}
