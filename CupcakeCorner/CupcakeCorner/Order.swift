//
//  Order.swift
//  CupcakeCorner
//
//  Created by Andy Kayley on 16/06/2022.
//

import SwiftUI

class Order: ObservableObject {
    @Published var orderLine = OrderLine()
}

struct OrderLine: Codable {

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkes = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkes = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // Complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkes {
            cost += Double(quantity) / 2
        }

        return cost 
    }

    init() { }

}
