//
//  TokenListRequest.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import CommonKit

struct TokenListRequest: NetworkRequest {
    let url: String
    let method: NetworkMethod = .get
    let transformerType: TransformerType = .json
    
    init(url: String) {
        self.url = url
    }
}
