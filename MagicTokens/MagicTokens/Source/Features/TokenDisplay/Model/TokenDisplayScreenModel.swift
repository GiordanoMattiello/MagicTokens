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
    
    init(token: Token, image: UIImage? = nil) {
        self.token = token
        self.image = image
    }
}
