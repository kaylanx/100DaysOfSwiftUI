//
//  DiceApp.swift
//  Dice
//
//  Created by Andy Kayley on 06/10/2022.
//

import SwiftUI

@main
struct DiceApp: App {

    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
