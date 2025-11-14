//
//  TokenListImageRequest.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import CommonKit

struct TokenListImageRequest: NetworkRequest {
    let url: String
    let method: NetworkMethod = .get
    let transformerType: TransformerType = .image
    
    init(url: String) {
        self.url = url
    }
}
