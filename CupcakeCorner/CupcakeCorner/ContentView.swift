//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Andy Kayley on 13/06/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderLine.type) {
                        ForEach(OrderLine.types.indices, id: \.self) {
                            Text(OrderLine.types[$0])
                        }
                    }

                    Stepper(
                        "Number of cakes: \(order.orderLine.quantity)",
                        value: $order.orderLine.quantity,
                        in: 3...20
                    )
                }

                Section {
                    Toggle("Any special requests?", isOn: $order.orderLine.specialRequestEnabled.animation())

                    if order.orderLine.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.orderLine.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.orderLine.addSprinkes)
                    }
                }

                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
