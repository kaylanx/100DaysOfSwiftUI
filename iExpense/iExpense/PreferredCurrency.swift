//
//  PreferredCurrency.swift
//  iExpense
//
//  Created by Andy Kayley on 07/05/2022.
//

import Foundation

enum PreferredCurrency {
    static let code = Locale.current.currencyCode ?? "USD"
}
