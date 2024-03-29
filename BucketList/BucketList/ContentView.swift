//
//  ContentView.swift
//  BucketList
//
//  Created by Andy Kayley on 25/07/2022.
//

import MapKit
import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        ZStack {
            if viewModel.isUnlocked {
                unlockedContent
            } else {
                Button("Unlock places") {
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) { newLocation in
                viewModel.update(location: newLocation)
            }
        }
        .alert(
            viewModel.authenticationError?.localizedDescription ?? "Authentication Error",
            isPresented: $viewModel.isShowingAuthenticationError
        ) { }
    }

    @ViewBuilder private var unlockedContent: some View {
        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                VStack {
                    Image(systemName: "star.circle")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 44, height: 44)
                        .background(.white)
                        .clipShape(Circle())

                    Text(location.name)
                        .fixedSize()
                }
                .onTapGesture {
                    viewModel.selectedPlace = location
                }
            }
        }
        .ignoresSafeArea()

        Circle()
            .fill(.blue)
            .opacity(0.3)
            .frame(width: 32, height: 32)

        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    viewModel.addLocation()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
