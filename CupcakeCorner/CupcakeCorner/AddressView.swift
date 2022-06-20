//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Andy Kayley on 16/06/2022.
//

import SwiftUI

struct AddressView: View {

    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderLine.name)
                TextField("Street address", text: $order.orderLine.streetAddress)
                TextField("City", text: $order.orderLine.city)
                TextField("Zip", text: $order.orderLine.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
            }
            .disabled(order.orderLine.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
