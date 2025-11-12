//
//  TokenListResponse.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

struct TokenListResponse: Codable {
    let object: String?
    let totalCards: Int?
    let hasMore: Bool?
    let nextPage: String?
    let tokens: [TokenScryFall]
    
    private enum CodingKeys: String, CodingKey {
        case object
        case totalCards = "total_cards"
        case hasMore = "has_more"
        case nextPage = "next_page"
        case tokens = "data"
    }
}
