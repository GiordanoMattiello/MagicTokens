//
//  TokenListAdapterMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//
@testable import MagicTokens
import UIKit

final class TokenListAdapterMock: TokenListAdapterProtocol {
    private(set) var tokenAdaptCallCount = 0
    private(set) var updateTokensReceivedTokens: TokenScryFall?
    var tokenAdaptReturnValue: Token?
    func tokenAdapt(_ token: TokenScryFall) -> Token? {
        tokenAdaptCallCount += 1
        updateTokensReceivedTokens = token
        return tokenAdaptReturnValue
    }
}
