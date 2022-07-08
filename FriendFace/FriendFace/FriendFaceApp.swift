//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Andy Kayley on 06/07/2022.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: UserViewModel())
        }
    }
}
