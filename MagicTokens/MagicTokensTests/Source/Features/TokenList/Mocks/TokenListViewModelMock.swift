//
//  TokenListViewModelMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

@testable import MagicTokens
import UIKit
import Combine

final class TokenListViewModelMock: TokenListViewModelProtocol {
    // MARK: - Published Properties
    @Published var screenModel: TokenListScreenModel = TokenListScreenModel(tokens: [])
    var screenModelPublisher: Published<MagicTokens.TokenListScreenModel>.Publisher { $screenModel }

    // MARK: - fetchTokens
    private(set) var fetchTokensCallCount = 0
    private(set) var fetchTokensReceivedURL: String?
    var fetchTokensCompletion: (()->Void)?
    func fetchTokens(url: String) async {
        fetchTokensCallCount += 1
        fetchTokensReceivedURL = url
        fetchTokensCompletion?()
    }

    // MARK: - fetchNextPageTokens
    private(set) var fetchNextPageTokensCallCount = 0
    func fetchNextPageTokens() async {
        fetchNextPageTokensCallCount += 1
    }

    // MARK: - loadImageFromURL
    private(set) var loadImageFromURLCallCount = 0
    private(set) var loadImageFromURLReceivedURL: String?
    var loadImageFromURLReturnValue: (()->UIImage?)?
    func loadImageFromURL(url: String) async -> UIImage? {
        loadImageFromURLCallCount += 1
        loadImageFromURLReceivedURL = url
        return loadImageFromURLReturnValue?()
    }

    // MARK: - didSelectToken
    private(set) var didSelectTokenCallCount = 0
    private(set) var didSelectTokenReceivedToken: Token?
    func didSelectToken(_ token: Token) {
        didSelectTokenCallCount += 1
        didSelectTokenReceivedToken = token
    }

    // MARK: - didTapRightButton
    private(set) var didTapRightButtonCallCount = 0
    func didTapRightButton() {
        didTapRightButtonCallCount += 1
    }

    
    private(set) var fetchTokensWithFilterCallCount = 0
    private(set) var fetchTokensWithFilterReceivedURL: String?
    var fetchTokensWithFilterCompletion: (()->Void)?
    func fetchTokensWithFilter(url: String) async {
        fetchTokensWithFilterCallCount += 1
        fetchTokensWithFilterReceivedURL = url
        fetchTokensWithFilterCompletion?()
    }
}
