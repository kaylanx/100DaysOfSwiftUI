//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 14/09/2022.
//

import Foundation

final class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}
