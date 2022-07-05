//
//  WizardsView.swift
//  CoreDataProject
//
//  Created by Andy Kayley on 03/07/2022.
//

import SwiftUI

struct WizardsView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: context)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct WizardsView_Previews: PreviewProvider {
    static var previews: some View {
        WizardsView()
    }
}
