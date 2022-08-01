//
//  EditView.swift
//  BucketList
//
//  Created by Andy Kayley on 27/07/2022.
//

import SwiftUI

struct EditView: View {

    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void

    @StateObject private var viewModel: ViewModel

    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                Section("Nearby") {
                    switch viewModel.loadingState {
                        case .loading:
                            ProgressView()
                        case .loaded:
                            ForEach(viewModel.pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                    .italic()
                            }
                        case .failed:
                            Text("Please try again later!")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    onSave(viewModel.createNewLocation())
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: PreviewLocation.previewLocation) { _ in }
    }
}
