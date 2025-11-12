//
//  TokenDisplayViewRequest.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import CommonKit

struct TokenDisplayViewRequest: NetworkRequest {
    let url: String
    let method: NetworkMethod = .get
    
    init(url: String) {
        self.url = url
    }
}
