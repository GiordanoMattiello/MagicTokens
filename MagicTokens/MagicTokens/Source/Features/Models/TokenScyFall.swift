//
//  TokenScyFall.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import Foundation

struct TokenScryFall: Codable {
    let object: String?
    let id: String?
    let oracleId: String?
    let multiverseIds: [Int]
    let tcgplayerId: Int?
    let name: String
    let lang: String?
    let releasedAt: String? // Format: YYYY-MM-DD
    let uri: String?
    let scryfallUri: String?
    let layout: String?
    let highresImage: Bool?
    let imageStatus: String?
    let imageUris: ImageUris?
    let manaCost: String?
    let cmc: Double?
    let typeLine: String
    let oracleText: String?
    let power: String?
    let toughness: String?
    let colors: [String]?
    let colorIdentity: [String]?
    let keywords: [String]?
    let allParts: [RelatedCard]?
    let legalities: Legalities?
    let games: [String]?
    let reserved: Bool?
    let foil: Bool?
    let nonfoil: Bool?
    let finishes: [String]?
    let oversized: Bool?
    let promo: Bool?
    let reprint: Bool?
    let variation: Bool?
    let setId: String?
    let set: String?
    let setName: String?
    let setType: String?
    let setUri: String?
    let setSearchUri: String?
    let scryfallSetUri: String?
    let rulingsUri: String?
    let printsSearchUri: String?
    let collectorNumber: String?
    let digital: Bool?
    let rarity: String?
    let cardBackId: String?
    let artist: String?
    let artistIds: [String]?
    let illustrationId: String?
    let borderColor: String?
    let frame: String?
    let fullArt: Bool?
    let textless: Bool?
    let booster: Bool?
    let storySpotlight: Bool?
    let promoTypes: [String]?
    let prices: Prices?
    let relatedUris: RelatedUris?
    let purchaseUris: PurchaseUris?
    let edhrecRank: Int?
    let pennyRank: Int?

    private enum CodingKeys: String, CodingKey {
        case object
        case id
        case oracleId = "oracle_id"
        case multiverseIds = "multiverse_ids"
        case tcgplayerId = "tcgplayer_id"
        case name
        case lang
        case releasedAt = "released_at"
        case uri
        case scryfallUri = "scryfall_uri"
        case layout
        case highresImage = "highres_image"
        case imageStatus = "image_status"
        case imageUris = "image_uris"
        case manaCost = "mana_cost"
        case cmc
        case typeLine = "type_line"
        case oracleText = "oracle_text"
        case power
        case toughness
        case colors
        case colorIdentity = "color_identity"
        case keywords
        case allParts = "all_parts"
        case legalities
        case games
        case reserved
        case foil
        case nonfoil
        case finishes
        case oversized
        case promo
        case reprint
        case variation
        case setId = "set_id"
        case set
        case setName = "set_name"
        case setType = "set_type"
        case setUri = "set_uri"
        case setSearchUri = "set_search_uri"
        case scryfallSetUri = "scryfall_set_uri"
        case rulingsUri = "rulings_uri"
        case printsSearchUri = "prints_search_uri"
        case collectorNumber = "collector_number"
        case digital
        case rarity
        case cardBackId = "card_back_id"
        case artist
        case artistIds = "artist_ids"
        case illustrationId = "illustration_id"
        case borderColor = "border_color"
        case frame
        case fullArt = "full_art"
        case textless
        case booster
        case storySpotlight = "story_spotlight"
        case promoTypes = "promo_types"
        case prices
        case relatedUris = "related_uris"
        case purchaseUris = "purchase_uris"
        case edhrecRank = "edhrec_rank"
        case pennyRank = "penny_rank"
    }
}

struct ImageUris: Codable {
    let small: String
    let normal: String
    let large: String
    let png: String
    let artCrop: String
    let borderCrop: String

    private enum CodingKeys: String, CodingKey {
        case small
        case normal
        case large
        case png
        case artCrop = "art_crop"
        case borderCrop = "border_crop"
    }
}

struct RelatedCard: Codable {
    let object: String
    let id: String
    let component: String
    let name: String
    let typeLine: String
    let uri: String

    private enum CodingKeys: String, CodingKey {
        case object
        case id
        case component
        case name
        case typeLine = "type_line"
        case uri
    }
}

struct Legalities: Codable {
    let standard: String
    let future: String
    let historic: String
    let timeless: String
    let gladiator: String
    let pioneer: String
    let modern: String
    let legacy: String
    let pauper: String
    let vintage: String
    let penny: String
    let commander: String
    let oathbreaker: String
    let standardbrawl: String
    let brawl: String
    let alchemy: String
    let paupercommander: String
    let duel: String
    let oldschool: String
    let premodern: String
    let predh: String
}

struct Prices: Codable {
    let usd: String?
    let usdFoil: String?
    let usdEtched: String?
    let eur: String?
    let eurFoil: String?
    let tix: String?

    private enum CodingKeys: String, CodingKey {
        case usd
        case usdFoil = "usd_foil"
        case usdEtched = "usd_etched"
        case eur
        case eurFoil = "eur_foil"
        case tix
    }
}

struct RelatedUris: Codable {
    let tcgplayerInfiniteArticles: String?
    let tcgplayerInfiniteDecks: String?
    let edhrec: String?
    let gatherer: String?

    private enum CodingKeys: String, CodingKey {
        case tcgplayerInfiniteArticles = "tcgplayer_infinite_articles"
        case tcgplayerInfiniteDecks = "tcgplayer_infinite_decks"
        case edhrec
        case gatherer
    }
}

struct PurchaseUris: Codable {
    let tcgplayer: String?
    let cardmarket: String?
    let cardhoarder: String?

    private enum CodingKeys: String, CodingKey {
        case tcgplayer
        case cardmarket
        case cardhoarder
    }
}
