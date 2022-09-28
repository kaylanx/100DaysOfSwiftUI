//
//  EditCards.swift
//  Flashzilla
//
//  Created by Andy Kayley on 26/09/2022.
//

import SwiftUI

struct EditCards: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CardViewModel()
    @State private var newPrompt = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }

                Section {
                    ForEach(viewModel.cards, id: \.self) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete { offsets in
                        viewModel.removeCards(at: offsets)
                    }
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .task {
                viewModel.loadData()
            }
        }
    }

    private func done() {
        dismiss()
    }

    private func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        viewModel.addCard(card: card)
        newPrompt = ""
        newAnswer = ""
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
