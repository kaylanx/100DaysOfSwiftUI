//
//  PreviewDataController.swift
//  Dice
//
//  Created by Andy Kayley on 12/10/2022.
//

import CoreData
import Foundation

class PreviewDataController {

    private let container = NSPersistentContainer(name: "DiceRolls")

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    init() {
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")

        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }


    func savePreviewData(diceRolls: [[String : Any]]) {

        diceRolls.forEach { diceRollDict in
            let diceRoll = DiceRoll(context: container.viewContext)
            diceRoll.id = UUID()
            diceRoll.totalRolled = diceRollDict["totalRolled"] as! Int16
            diceRoll.numberOfSides = diceRollDict["numberOfSides"] as! Int16
            diceRoll.numberOfDice = diceRollDict["numberOfDice"]  as! Int16
            diceRoll.dateOfRoll = diceRollDict["dateOfRoll"] as? Date
        }
    }
}
