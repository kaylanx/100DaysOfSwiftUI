//
//  GesturesView.swift
//  Flashzilla
//
//  Created by Andy Kayley on 20/09/2022.
//

import SwiftUI

enum Gestures {

    struct TapLongPressView: View {

        var body: some View {
            VStack {
                Spacer()

                Text("Hello, World!")
                    .onTapGesture(count:2) {
                        print("Double tap")
                    }
                    .onLongPressGesture(minimumDuration: 5) {
                        print("Long press for 5 seconds")
                    }
                    .onLongPressGesture {
                        print("Long press")
                    }

                Spacer()

                Text("Goodbye, World!")
                    .onLongPressGesture(minimumDuration: 1) {
                        print("Long pressed!")
                    } onPressingChanged: { inProgress in
                        print("In progress: \(inProgress)!")
                    }
                
                Spacer()
            }
        }
    }

    struct PinchToMagnifyView: View {

        @State private var currentAmount = 0.0
        @State private var finalAmount = 1.0

        var body: some View {
            Text("Pinch Me!")
                .scaleEffect(currentAmount + finalAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { amount in
                            currentAmount = amount - 1
                        }
                        .onEnded { amount in
                            finalAmount += currentAmount
                            currentAmount = 0
                        }
                )
        }
    }

    struct RotateView: View {
        @State private var currentAmount = Angle.zero
        @State private var finalAmount = Angle.zero

        var body: some View {
            Text("Rotate Me!")
                .rotationEffect(currentAmount + finalAmount)
                .gesture(
                    RotationGesture()
                        .onChanged { angle in
                            currentAmount = angle
                        }
                        .onEnded { amount in
                            finalAmount += currentAmount
                            currentAmount = .zero
                        }
                )
        }
    }

    struct ChildTapWinsView: View {
        var body: some View {
            VStack {
                Text("Hello, World!")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .onTapGesture {
                print("VStack tapped")
            }
        }
    }

    struct ParentTapWinsView: View {
        var body: some View {
            VStack {
                Text("Hello, World!")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .highPriorityGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
        }
    }

    struct BothGesturesExecuteView: View {
        var body: some View {
            VStack {
                Text("Hello, World!")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
        }
    }

    struct GestureSequencingView: View {
        // how far the circle has been dragged
        @State private var offset = CGSize.zero

        // whether it is currently being dragged or not
        @State private var isDragging = false

        var body: some View {
            // a drag gesture that updates offset and isDragging as it moves around
            let dragGesture = DragGesture()
                .onChanged { value in offset = value.translation }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }

            // a long press gesture that enables isDragging
            let pressGesture = LongPressGesture()
                .onEnded { value in
                    withAnimation {
                        isDragging = true
                    }
                }

            // a combined gesture that forces the user to long press then drag
            let combined = pressGesture.sequenced(before: dragGesture)

            // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
        }
    }

    struct GesturesView_Previews: PreviewProvider {
        static var previews: some View {
            Gestures.TapLongPressView()
            Gestures.PinchToMagnifyView()
            Gestures.RotateView()
            Gestures.ChildTapWinsView()
            Gestures.ParentTapWinsView()
            Gestures.BothGesturesExecuteView()
            Gestures.GestureSequencingView()
        }
    }
}
