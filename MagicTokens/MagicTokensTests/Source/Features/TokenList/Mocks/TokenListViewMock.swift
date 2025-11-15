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
    private(set) var configureCallCount = 0
    private(set) var configureReceivedModel: TokenListScreenModel?
    var configureCompletion: (()->Void)?
    func configure(model: TokenListScreenModel) {
        configureCallCount += 1
        configureReceivedModel = model
        configureCompletion?()
    }
}
