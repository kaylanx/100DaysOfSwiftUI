//
//  SheetExampleView.swift
//  iExpense
//
//  Created by Andy Kayley on 04/05/2022.
//

import SwiftUI

struct SecondView: View {

    @Environment(\.dismiss) var dismiss

    let name: String
    var body: some View {
        VStack {
            Text("Hello \(name)!")
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

struct SheetExampleView: View {

    @State private var showingSheet = false

    var body: some View {
        Button("Show sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@darthmoonmonkey")
        }
    }
}

struct SheetExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SheetExampleView()
    }
}
