//
//  AddView.swift
//  iExpense
//
//  Created by Andy Kayley on 05/05/2022.
//

import SwiftUI

struct AddView: View {

    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss


    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: PreferredCurrency.code))
                    .keyboardType(.decimalPad)
                Text(name)
                Text(type)
                Text("\(amount)")
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
