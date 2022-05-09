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
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: PreferredCurrency.code))
                            .amountStyle(for: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
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

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
