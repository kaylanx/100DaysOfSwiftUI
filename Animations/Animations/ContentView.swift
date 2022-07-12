//
//  ContentView.swift
//  Animations
//
//  Created by Andy Kayley on 19/04/2022.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {

    @State private var isShowingRed = false

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}


struct TransitionsContentView: View {

    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct AnimatingGestures2ContentView: View {

    let letters = Array("Hello, SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { index in
                Text(String(letters[index]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(index) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragGestureValue in
                    dragAmount = dragGestureValue.translation
                }
                .onEnded { _ in
                    withAnimation {
                        dragAmount = .zero
                        enabled.toggle()
                    }
                }
        )
    }
}

struct AnimatingGestures1ContentView: View {

    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.yellow, .red]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(width: 300, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(dragAmount)
        .gesture(
            DragGesture()
                .onChanged { dragGestureValue in
                    dragAmount = dragGestureValue.translation
                }
                .onEnded { _ in
                    withAnimation {
                        dragAmount = .zero
                    }
                }
        )
        //        .animation(.spring(), value: dragAmount)
    }
}

struct MultipleAnimationsContentView: View {

    @State private var enabled = true

    var body: some View {
        Button("Tap me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(.default, value: enabled)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
    }
}


struct CircleContentView: View {

    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
            //            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .onAppear {
            animationAmount += 2
        }

    }
}

struct BindingAnimationContentView: View {

    @State private var animationAmount = 1.0

    var body: some View {
        print(animationAmount)

        return VStack {
            Stepper("Scale amount",
                    value: $animationAmount.animation(
                        .easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)
                    ),
                    in: 1...10)
            Spacer()
            Button("Tap me") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct SpinnerContentView: View {

    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransitionsContentView()
        AnimatingGestures2ContentView()
        AnimatingGestures1ContentView()
        MultipleAnimationsContentView()
        CircleContentView()
        SpinnerContentView()
        BindingAnimationContentView()
        ContentView()
    }
}
