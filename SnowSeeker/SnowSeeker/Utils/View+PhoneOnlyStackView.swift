//
//  View+PhoneOnlyStackView.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 27/10/2022.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
