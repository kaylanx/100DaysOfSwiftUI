//
//  Resort+Preview.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 27/10/2022.
//

import Foundation

extension Resort {
    static let previewAllResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let previewResort = previewAllResorts[0]
}
