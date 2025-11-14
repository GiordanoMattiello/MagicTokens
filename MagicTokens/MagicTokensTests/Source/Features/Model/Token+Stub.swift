//
//  Token+Stub.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

@testable import MagicTokens

extension Token {
    static func stub(smallImageURL: String = "smallImageURL",
                     largeImageURL: String = "largeImageURL",
                     name: String = "Token name",
                     type: String = "Token type") -> Token {
        return Token(smallImageURL: smallImageURL, largeImageURL: largeImageURL, name: name, type: type)
    }
}
