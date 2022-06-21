//
//  ContentView.swift
//  Bookworm
//
//  Created by Andy Kayley on 21/06/2022.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>

    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }

            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Potter", "Lovegood", "Weasley" ]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                let student = Student(context: context)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"

                try? context.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
