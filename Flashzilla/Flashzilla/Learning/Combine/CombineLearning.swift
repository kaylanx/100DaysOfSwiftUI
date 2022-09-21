//
//  Combine.swift
//  Flashzilla
//
//  Created by Andy Kayley on 21/09/2022.
//

import SwiftUI

enum CombineLearning {

    struct ContentView: View {
        private let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

        @State private var counter = 0

        var body: some View {
            Text("Hello, World!")
                .onReceive(timer) { time in
                    if counter == 5 {
                        timer.upstream.connect().cancel()
                    } else {
                        print("The time is now \(time)")
                    }
                    counter += 1
                }
        }
    }
}
