//
//  PhotoNameView.swift
//  PhotoNames
//
//  Created by Andy Kayley on 30/08/2022.
//

import SwiftUI

struct PhotoNameView: View {

    @Binding var photoName: String
    var saveAction: () -> Void

    @State private var isSaving = false

    var body: some View {
        Group {
            if isSaving {
                ProgressView()
            } else {
                Form {
                    TextField("Photo Name", text: $photoName)
                    Button("Save") {
                        isSaving = true
                        saveAction()
                    }
                }
            }
        }
        .navigationTitle("Name the photo")
    }
}

struct PhotoNameView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoNameView(
            photoName: .constant("Some name")
        ) {
            
        }
    }
}
