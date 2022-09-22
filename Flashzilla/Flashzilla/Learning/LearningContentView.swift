//
//  LearningContentView.swift
//  Flashzilla
//
//  Created by Andy Kayley on 22/09/2022.
//

import SwiftUI

struct LearningContentView: View {
    var body: some View {
        //        Gestures.TapLongPressView()
        //        Gestures.PinchToMagnifyView()
        //        Gestures.RotateView()
        //        Gestures.ChildTapWinsView()
        //        Gestures.ParentTapWinsView()
        //        Gestures.BothGesturesExecuteView()
        //        Gestures.GestureSequencingView()
        //        Haptics.ContentView()
        //        HitTesting.AllowsHitTestingContentView()
        //        HitTesting.SpacersDontGetTaps()
        //        HitTesting.SpacersGetsTaps()
        //        CombineLearning.ContentView()
        //        ScenePhase.ContentView()
        //        Accessibility.DifferentiateWithoutColor()
        //        Accessibility.ReduceMotion()
        //        Accessibility.ReduceMotion2()
        Accessibility.ReduceTransparency()
    }
}

struct LearningContentView_Previews: PreviewProvider {
    static var previews: some View {
        LearningContentView()
    }
}
