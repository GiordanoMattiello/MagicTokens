//
//  TokenScryFall+Stub.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

@testable import MagicTokens

extension TokenScryFall {
    static func stub(
        object: String? = "card",
        id: String? = "id_123",
        oracleId: String? = "oracle_123",
        multiverseIds: [Int] = [1001, 1002],
        tcgplayerId: Int? = 9999,
        name: String = "Token Name",
        lang: String? = "en",
        releasedAt: String? = "2024-01-01",
        uri: String? = "https://api.scryfall.com/cards/id_123",
        scryfallUri: String? = "https://scryfall.com/card/id_123",
        layout: String? = "normal",
        highresImage: Bool? = true,
        imageStatus: String? = "highres_scan",
        imageUris: ImageUris? = .stub(),
        manaCost: String? = "{2}{W}",
        cmc: Double? = 2,
        typeLine: String = "Token Creature — Spirit",
        oracleText: String? = "Flying",
        power: String? = "1",
        toughness: String? = "1",
        colors: [String]? = ["W"],
        colorIdentity: [String]? = ["W"],
        keywords: [String]? = ["Flying"],
        allParts: [RelatedCard]? = [.stub()],
        legalities: Legalities? = .stub(),
        games: [String]? = ["paper", "mtgo"],
        reserved: Bool? = false,
        foil: Bool? = true,
        nonfoil: Bool? = true,
        finishes: [String]? = ["nonfoil", "foil"],
        oversized: Bool? = false,
        promo: Bool? = false,
        reprint: Bool? = true,
        variation: Bool? = false,
        setId: String? = "set_123",
        set: String? = "SET",
        setName: String? = "Set Name",
        setType: String? = "expansion",
        setUri: String? = "https://api.scryfall.com/sets/set_123",
        setSearchUri: String? = "https://api.scryfall.com/cards/search",
        scryfallSetUri: String? = "https://scryfall.com/sets/set_123",
        rulingsUri: String? = "https://api.scryfall.com/cards/id_123/rulings",
        printsSearchUri: String? = "https://api.scryfall.com/cards/search?q=id_123",
        collectorNumber: String? = "001",
        digital: Bool? = false,
        rarity: String? = "common",
        cardBackId: String? = "cardback_123",
        artist: String? = "John Doe",
        artistIds: [String]? = ["artist_123"],
        illustrationId: String? = "illu_123",
        borderColor: String? = "black",
        frame: String? = "2015",
        fullArt: Bool? = false,
        textless: Bool? = false,
        booster: Bool? = true,
        storySpotlight: Bool? = false,
        promoTypes: [String]? = nil,
        prices: Prices? = .stub(),
        relatedUris: RelatedUris? = .stub(),
        purchaseUris: PurchaseUris? = .stub(),
        edhrecRank: Int? = 12345,
        pennyRank: Int? = 99999
    ) -> TokenScryFall {
        return TokenScryFall(
            object: object,
            id: id,
            oracleId: oracleId,
            multiverseIds: multiverseIds,
            tcgplayerId: tcgplayerId,
            name: name,
            lang: lang,
            releasedAt: releasedAt,
            uri: uri,
            scryfallUri: scryfallUri,
            layout: layout,
            highresImage: highresImage,
            imageStatus: imageStatus,
            imageUris: imageUris,
            manaCost: manaCost,
            cmc: cmc,
            typeLine: typeLine,
            oracleText: oracleText,
            power: power,
            toughness: toughness,
            colors: colors,
            colorIdentity: colorIdentity,
            keywords: keywords,
            allParts: allParts,
            legalities: legalities,
            games: games,
            reserved: reserved,
            foil: foil,
            nonfoil: nonfoil,
            finishes: finishes,
            oversized: oversized,
            promo: promo,
            reprint: reprint,
            variation: variation,
            setId: setId,
            set: set,
            setName: setName,
            setType: setType,
            setUri: setUri,
            setSearchUri: setSearchUri,
            scryfallSetUri: scryfallSetUri,
            rulingsUri: rulingsUri,
            printsSearchUri: printsSearchUri,
            collectorNumber: collectorNumber,
            digital: digital,
            rarity: rarity,
            cardBackId: cardBackId,
            artist: artist,
            artistIds: artistIds,
            illustrationId: illustrationId,
            borderColor: borderColor,
            frame: frame,
            fullArt: fullArt,
            textless: textless,
            booster: booster,
            storySpotlight: storySpotlight,
            promoTypes: promoTypes,
            prices: prices,
            relatedUris: relatedUris,
            purchaseUris: purchaseUris,
            edhrecRank: edhrecRank,
            pennyRank: pennyRank
        )
    }
}

extension ImageUris {
    static func stub(
        small: String = "https://example.com/small.png",
        normal: String = "https://example.com/normal.png",
        large: String = "https://example.com/large.png",
        png: String = "https://example.com/image.png",
        artCrop: String = "https://example.com/art_crop.png",
        borderCrop: String = "https://example.com/border_crop.png"
    ) -> ImageUris {
        return ImageUris(
            small: small,
            normal: normal,
            large: large,
            png: png,
            artCrop: artCrop,
            borderCrop: borderCrop
        )
    }
}

extension RelatedCard {
    static func stub(
        object: String = "related_card",
        id: String = "related_123",
        component: String = "token",
        name: String = "Spirit",
        typeLine: String = "Token Creature — Spirit",
        uri: String = "https://api.scryfall.com/cards/related_123"
    ) -> RelatedCard {
        return RelatedCard(
            object: object,
            id: id,
            component: component,
            name: name,
            typeLine: typeLine,
            uri: uri
        )
    }
}

extension Legalities {
    static func stub(
        standard: String = "legal",
        future: String = "legal",
        historic: String = "legal",
        timeless: String = "legal",
        gladiator: String = "legal",
        pioneer: String = "legal",
        modern: String = "legal",
        legacy: String = "legal",
        pauper: String = "not_legal",
        vintage: String = "legal",
        penny: String = "not_legal",
        commander: String = "legal",
        oathbreaker: String = "legal",
        standardbrawl: String = "legal",
        brawl: String = "not_legal",
        alchemy: String = "not_legal",
        paupercommander: String = "legal",
        duel: String = "not_legal",
        oldschool: String = "not_legal",
        premodern: String = "not_legal",
        predh: String = "not_legal"
    ) -> Legalities {
        return Legalities(
            standard: standard,
            future: future,
            historic: historic,
            timeless: timeless,
            gladiator: gladiator,
            pioneer: pioneer,
            modern: modern,
            legacy: legacy,
            pauper: pauper,
            vintage: vintage,
            penny: penny,
            commander: commander,
            oathbreaker: oathbreaker,
            standardbrawl: standardbrawl,
            brawl: brawl,
            alchemy: alchemy,
            paupercommander: paupercommander,
            duel: duel,
            oldschool: oldschool,
            premodern: premodern,
            predh: predh
        )
    }
}

extension Prices {
    static func stub(
        usd: String? = "1.00",
        usdFoil: String? = "2.00",
        usdEtched: String? = nil,
        eur: String? = "0.90",
        eurFoil: String? = "1.80",
        tix: String? = "0.10"
    ) -> Prices {
        return Prices(
            usd: usd,
            usdFoil: usdFoil,
            usdEtched: usdEtched,
            eur: eur,
            eurFoil: eurFoil,
            tix: tix
        )
    }
}

extension RelatedUris {
    static func stub(
        tcgplayerInfiniteArticles: String? = "https://tcg/articles",
        tcgplayerInfiniteDecks: String? = "https://tcg/decks",
        edhrec: String? = "https://edhrec.com/card",
        gatherer: String? = "https://gatherer.wizards.com"
    ) -> RelatedUris {
        return RelatedUris(
            tcgplayerInfiniteArticles: tcgplayerInfiniteArticles,
            tcgplayerInfiniteDecks: tcgplayerInfiniteDecks,
            edhrec: edhrec,
            gatherer: gatherer
        )
    }
}

extension PurchaseUris {
    static func stub(
        tcgplayer: String? = "https://tcgplayer.com/buy",
        cardmarket: String? = "https://cardmarket.com/buy",
        cardhoarder: String? = "https://cardhoarder.com/buy"
    ) -> PurchaseUris {
        return PurchaseUris(
            tcgplayer: tcgplayer,
            cardmarket: cardmarket,
            cardhoarder: cardhoarder
        )
    }
}
