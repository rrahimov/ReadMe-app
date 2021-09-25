//
//  ContentView.swift
//  ReadMe
//
//  Created by Ruhullah Rahimov on 11.09.21.
//

import SwiftUI

struct ContentView: View {
    @State var library = Library()
    @State var addingNewBook = false
    
    var body: some View {
        NavigationView {
            //as Book is hashable we can use .self as it's ID instead of one of it's properties (.title for example).
            List {
                Button{
                    addingNewBook = true
                } label: {
                    
                    Spacer()
                    VStack(spacing: 6.0) {
                        Image(systemName: "book.circle")
                            .font(.system(size: 60))
                        Text("Add New Book")
                            .font(.title2)
                    }
                    Spacer()
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.vertical, 8)
                .sheet(isPresented: $addingNewBook, content: NewBookView.init)
                
                ForEach(library.sortedBooks) { book in
                    BookRow(book: book, image: $library.uiImages[book])
                }
            }
            .navigationTitle("My Library")
        }
    }
}

struct BookRow: View {
    @ObservedObject var book: Book
    @Binding var image: UIImage?
    
    var body: some View {
        //When you tap on each one of these rows, that should bring up an instance of your new DetailView provided with the book you tapped on. To do that, create a navigation link at the top of body.
        NavigationLink(
            destination: DetailView(book: book, image: $image)
        ) {
            HStack {
                Book.Image(uiImage: image, title: book.title, size: 80, cornerRadius: 12)
                VStack(alignment: .leading) {
                    TitleAndAuthorStack(book: book, titleFont: .title2, authorFont: .title3)
                    if !book.microReview.isEmpty {
                        Spacer()
                    Text(book.microReview)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
                .lineLimit(1)
                
                Spacer()
                
                BookmarkButton(book: book)
                    .buttonStyle(BorderlessButtonStyle())
            }
            .padding(.vertical, 8)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewedInAllColorSchemes
    }
}

