//
//  ContentView.swift
//  PhotoNames
//
//  Created by Andy Kayley on 10/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PhotoListView(viewModel: PhotoListView.ViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
