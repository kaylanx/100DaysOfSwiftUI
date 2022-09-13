//
//  SPM.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 13/09/2022.
//

import SwiftUI
import SamplePackage

enum SPM {
    struct ContentView: View {

        private let possibleNumbers = Array(1...60)

        private var results: String {
            let selected = possibleNumbers.random(7).sorted()
            let strings = selected.map(String.init)
            return strings.joined(separator: ", ")
        }

        var body: some View {
            Text(results)
        }
    }
}
