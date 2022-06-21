//
//  TextEditorAppStorageExampleView.swift
//  Bookworm
//
//  Created by Andy Kayley on 21/06/2022.
//

import SwiftUI

struct TextEditorAppStorageExampleView: View {

    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct TextEditorAppStorageExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorAppStorageExampleView()
    }
}
