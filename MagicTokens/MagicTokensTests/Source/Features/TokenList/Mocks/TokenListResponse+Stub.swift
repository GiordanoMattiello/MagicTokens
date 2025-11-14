//
//  TokenListResponse+Stub.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import Foundation
@testable import MagicTokens

extension TokenListResponse {
    static func stub(
        object: String? = "list",
        totalCards: Int? = 100,
        hasMore: Bool? = true,
        nextPage: String? = "nextPage-url",
        tokens: [TokenScryFall] = [.stub()]
    ) -> TokenListResponse {
        return TokenListResponse(
            object: object,
            totalCards: totalCards,
            hasMore: hasMore,
            nextPage: nextPage,
            tokens: tokens
        )
    }
}
