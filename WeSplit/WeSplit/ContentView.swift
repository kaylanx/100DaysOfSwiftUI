//
//  ContentView.swift
//  WeSplit
//
//  Created by Andy Kayley on 14/03/2022.
//

import SwiftUI

struct ContentView: View {
  
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 20
  @FocusState private var amountIsFocused: Bool
  
  private let tipPercentages = [10, 15, 20, 25, 0]
  
  private var currency: FloatingPointFormatStyle<Double>.Currency {
    .currency(code: Locale.current.currencyCode ?? "USD")
  }
  
  private var totalPerPerson: Double {
    // Calculate the total per person here
    let peopleCount = Double(numberOfPeople + 2)
    return grandTotal / peopleCount
  }
  
  private var grandTotal: Double {
    let tipSelection = Double(tipPercentage)
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    return grandTotal
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField(
            "Amount",
            value: $checkAmount,
            format: .currency(code: Locale.current.currencyCode ?? "USD")
          )
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
          
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2..<100) {
              Text("\($0)")
            }
          }
        }
        
        Section {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(tipPercentages, id: \.self) {
              Text($0, format: .percent)
            }
          }
          .pickerStyle(.segmented)
        } header: {
          Text("How much tip do you want to leave?")
        }
        
        Section {
          Text(totalPerPerson, format: currency)
        } header: {
          Text("Amount per person")
        }
        
        Section {
          Text(grandTotal, format: currency)
        } header: {
          Text("Grand todal")
        }
      }
      .navigationBarTitle("WeSplit")
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()
          Button("Done") {
            amountIsFocused = false
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
