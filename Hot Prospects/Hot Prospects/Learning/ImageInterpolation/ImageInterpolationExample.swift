//
//  ImageInterpolationExample.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 11/09/2022.
//

import SwiftUI

enum ImageInterpolationExample {

    struct ContentView: View {
        var body: some View {
            Image("example")
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .background(.black)
                .ignoresSafeArea()
        }
    }
}
