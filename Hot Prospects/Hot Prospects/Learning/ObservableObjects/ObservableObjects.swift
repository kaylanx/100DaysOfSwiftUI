//
//  ObservableObjects.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 11/09/2022.
//

import SwiftUI

enum ObservableObjects {

    @MainActor class DelayedUpdater: ObservableObject {
        var value = 0 {
            willSet {
                objectWillChange.send()
            }
        }

        init() {
            for i in 1...10 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                    self.value += 1
                }
            }
        }
    }

    struct ContentView: View {

        @StateObject var updater = DelayedUpdater()

        var body: some View {
            Text("Value is: \(updater.value)")
        }
    }
}
