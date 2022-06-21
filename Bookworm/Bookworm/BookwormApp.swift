//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Andy Kayley on 21/06/2022.
//

import SwiftUI

@main
struct BookwormApp: App {

    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
