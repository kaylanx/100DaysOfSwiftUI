//
//  ContentView.swift
//  FriendFace
//
//  Created by Andy Kayley on 06/07/2022.
//

import SwiftUI

struct ContentView: View {

    var viewModel: UserViewModel

//    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
//
//    var body: some View {
//        GeometryReader { fullView in
//            ScrollView {
//                ForEach(0..<50) { index in
//                    GeometryReader { geo in
//                        Text("Row #\(index)")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
//                            .background(colors[index % 7])
//                            .rotation3DEffect(
//                                .degrees(
//                                    geo.frame(in: .global).minY - fullView.size.height / 2
//                                ) / 5,
//                                axis: (x: 0, y: 1, z: 0)
//                            )
//                    }
//                    .frame(height: 40)
//                }
//            }
//        }
//    }
    var body: some View {
        NavigationView {
            UserListView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    private static var viewModel = UserViewModel(userRepository: PreviewUserRepository())

    static var previews: some View {
        ContentView(viewModel: viewModel)
        
    }
}
