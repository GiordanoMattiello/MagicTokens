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
                     type: String = "Token type",
                     power: String? = "1",
                     toughness: String? = "1") -> Token {
        return Token(smallImageURL: smallImageURL, 
                    largeImageURL: largeImageURL, 
                    name: name, 
                    type: type,
                    power: power,
                    toughness: toughness)
    }
}
