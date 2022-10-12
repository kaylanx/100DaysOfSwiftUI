//
//  DataController.swift
//  Dice
//
//  Created by Andy Kayley on 11/10/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    private let container = NSPersistentContainer(name: "DiceRolls")

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
