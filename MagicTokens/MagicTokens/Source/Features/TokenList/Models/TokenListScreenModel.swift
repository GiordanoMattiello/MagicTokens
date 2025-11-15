//
//  TokenListScreenModel.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 15/11/25.
//

import UIKit

struct TokenListScreenModel: Equatable {
    var tokens: [Token]
    var isLoading: Bool
    
    init(tokens: [Token] = [], isLoading: Bool = true) {
        self.tokens = tokens
        self.isLoading = isLoading
    }
}

