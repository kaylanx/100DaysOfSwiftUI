//
//  DeleteFromListExampleView.swift
//  iExpense
//
//  Created by Andy Kayley on 04/05/2022.
//

import SwiftUI

struct DeleteFromListExampleView: View {

    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(numbers, id: \.self) { number in
                        Text("Row \(number)")
                    }
                    .onDelete(perform: removeRows)
                }

                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("onDelete()")
            .toolbar {
                EditButton()
            }

        }
    }

    func removeRows(at indexSet: IndexSet) {
        numbers.remove(atOffsets: indexSet)
    }
}

struct DeleteFromListExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteFromListExampleView()
    }
}
