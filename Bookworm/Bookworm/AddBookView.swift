//
//  AddBookView.swift
//  Bookworm
//
//  Created by Andy Kayley on 23/06/2022.
//

import SwiftUI

struct AddBookView: View {

    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""

    private var isFormValid: Bool {
        title.isEmpty == false &&
        author.isEmpty == false &&
        genre.isEmpty == false
    }

    private let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header : {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: context)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review.isEmpty ? "Not reviewed" : review

                        try? context.save()
                        dismiss()
                    }
                }
                .disabled(isFormValid == false)
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
