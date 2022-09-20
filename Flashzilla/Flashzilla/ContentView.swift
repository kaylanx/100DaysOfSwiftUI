//
//  ContentView.swift
//  Flashzilla
//
//  Created by Andy Kayley on 20/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Gestures.TapLongPressView()
//        Gestures.PinchToMagnifyView()
//        Gestures.RotateView()
//        Gestures.ChildTapWinsView()
//        Gestures.ParentTapWinsView()
//        Gestures.BothGesturesExecuteView()
//        Gestures.GestureSequencingView()
        Haptics.ContentView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
