//
//  BookViews.swift
//  ReadMe
//
//  Created by Ruhullah Rahimov on 11.09.21.
//

import SwiftUI

struct BookmarkButton: View {
    @ObservedObject var book: Book
    
    var body: some View {
        let bookmark = "bookmark"
        Button {
            book.readMe.toggle()
        } label: {
            Image(systemName: book.readMe ? "\(bookmark).fill" : bookmark)
                .font(.system(size: 48, weight: .light))
        }
    }
}

struct TitleAndAuthorStack: View {
    let book: Book
    let titleFont: Font
    let authorFont: Font
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(titleFont)
            Text(book.author)
                .font(authorFont)
                .foregroundColor(.secondary)
        }
    }
}

extension Book {
    struct Image: View {
        let uiImage: UIImage?
        let title: String
        var size: CGFloat?
        let cornerRadius: CGFloat

        
            var body: some View {
                if let image = uiImage.map(SwiftUI.Image.init) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .cornerRadius(cornerRadius)
                } else {
                let symbol = SwiftUI.Image(title: title) ?? .init(systemName: "book")
                //compiler knows that the types have to match on either side of the operator, so use .init instead of SwiftUI.Image
                symbol
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .font(Font.title.weight(.light))
                    .foregroundColor(.secondary)
                }
            }
        }
    }

struct Book_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Book.Image(title: Book().title)
            Book.Image(title: "")
            Book.Image(title: "😃")
        }
        .previewedInAllColorSchemes
    }
}

extension Image {
    // we wont always have an image to represent title, so we added ? to init.
    init?(title: String) {
        guard
            let character = title.first,
        //because it's not optional we use case let
        case let symbolName = "\(character.lowercased()).square",
        UIImage(systemName: symbolName) != nil
        else {
            return nil
        }
        
        self.init(systemName: symbolName)
    }
}

extension Book.Image {
    /// A preview Image.
    init(title: String) {
        self.init(uiImage: nil, title: title, cornerRadius: .init())
    }
}

extension View {
    var previewedInAllColorSchemes: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: preferredColorScheme)
    }
}
