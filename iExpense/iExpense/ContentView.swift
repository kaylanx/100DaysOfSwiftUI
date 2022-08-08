//
//  ContentView.swift
//  iExpense
//
//  Created by Andy Kayley on 04/05/2022.
//

import SwiftUI

struct AmountStyle: ViewModifier {
    let amount: Double

    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(7)
            .background(color(for: amount))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private func color(for amount: Double) -> Color {
        if amount < 10 {
            return Color.blue
        } else if amount < 100 {
            return Color.purple
        }
        return Color.red
    }
}

extension View {
    func amountStyle(for amount: Double) -> some View {
        modifier(AmountStyle(amount: amount))
    }
}

struct ContentView: View {

    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal")) {
                    ForEach(expenses.items.filter { $0.isPersonal }) { item in
                        cell(for: item)
                    }
                    .onDelete { removeItem(at: $0, in: .personal) }
                }
                Section(header: Text("Business")) {
                    ForEach(expenses.items.filter { $0.isBusiness }) { item in
                        cell(for: item)
                    }
                    .onDelete { removeItem(at: $0, in: .business) }
                }
            }
            .navigationTitle(
                Text("iExpense")
                    .accessibilityLabel("I Expense")
            )
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    private func cell(for expenseItem: ExpenseItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expenseItem.name)
                    .font(.headline)
                Text(expenseItem.type.rawValue)
                    .font(.subheadline)
            }
            Spacer()
            Text(
                expenseItem.amount,
                format: .currency(code: PreferredCurrency.code)
            )
            .amountStyle(for: expenseItem.amount)
        }
        .accessibilityElement()
        .accessibilityLabel("\(expenseItem.name) \(format(cost: expenseItem.amount))")
        .accessibilityHint(expenseItem.type.rawValue)
    }

    private func format(cost: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = PreferredCurrency.code

        if let result = formatter.string(from: cost as NSNumber) {
            return result
        }
        return "\(cost)"
    }

    private func removeItem(at offsets: IndexSet, in section: ExpenseType) {
        let expensesForType = expenses.items.filter { $0.type == section }
        offsets.forEach { indexInSection in
            let expense = expensesForType[indexInSection]
            if let index = expenses.items.firstIndex(of: expense) {
                expenses.items.remove(at: index)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
