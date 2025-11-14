//
//  TokenListViewMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

@testable import MagicTokens
import UIKit

final class TokenListViewMock: UIView, TokenListViewProtocol {

    // MARK: - Delegate
    var delegate: TokenListViewControllerDelegate?

    // MARK: - updateTokens
    private(set) var updateTokensCallCount = 0
    private(set) var updateTokensReceivedTokens: [Token]?
    var updateTokensCompletion: (()->Void)?
    func updateTokens(_ tokens: [Token]) {
        updateTokensCallCount += 1
        updateTokensReceivedTokens = tokens
        updateTokensCompletion?()
    }
}
