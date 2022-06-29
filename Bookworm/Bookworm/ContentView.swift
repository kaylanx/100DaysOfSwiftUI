//
//  ContentView.swift
//  Bookworm
//
//  Created by Andy Kayley on 21/06/2022.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.title),  // order: .reverse) // Can also pass in the order.
            SortDescriptor(\.author)
        ]
    )
    private var books: FetchedResults<Book>
    @State private var isShowingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? Color.red : Color.primary)
                                Text("by \(book.author ?? "Unknown")")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddScreen.toggle()
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddScreen) {
                AddBookView()
            }
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            context.delete(book)
        }

        try? context.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
