//
//  Collection+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
