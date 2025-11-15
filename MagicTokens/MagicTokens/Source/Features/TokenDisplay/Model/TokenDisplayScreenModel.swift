//
//  TokenDisplayScreenModel.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 15/11/25.
//

import UIKit

struct TokenDisplayScreenModel {
    var token: Token
    var image: UIImage?
    var isLoading: Bool
    
    init(token: Token, image: UIImage? = nil, isLoading: Bool = false) {
        self.token = token
        self.image = image
        self.isLoading = isLoading
    }
}
