//
//  BookViews.swift
//  ReadMe
//
//  Created by Ruhullah Rahimov on 11.09.21.
//

import SwiftUI

extension Book {
    struct Image: View {
        let title: String
        
        var body: some View {
            let symbol = SwiftUI.Image(title: title) ?? .init(systemName: "book")
            //compiler knows that the types have to match on either side of the operator, so use .init instead of SwiftUI.Image
            symbol
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .font(Font.title.weight(.light))
                .foregroundColor(.secondary)
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
