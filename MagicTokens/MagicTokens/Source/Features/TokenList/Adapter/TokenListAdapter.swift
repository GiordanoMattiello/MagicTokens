//
//  TokenListAdapter.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

protocol TokenListAdapterProtocol {
    func tokenAdapt(_ token: TokenScryFall) -> Token?
}

final class TokenListAdapter: TokenListAdapterProtocol {
    func tokenAdapt(_ scryToken: TokenScryFall) -> Token? {
        guard let imagesUris = scryToken.imageUris else { return nil }
        let token = Token(smallImageURL: imagesUris.small,
                          largeImageURL: imagesUris.large,
                          name: scryToken.name,
                          type: scryToken.typeLine,
                          power: scryToken.power,
                          toughness: scryToken.toughness
        )
        return token
    }
}
