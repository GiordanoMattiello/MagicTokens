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
    
    @Published var tokens: [Token] = []
    var tokensPublisher: Published<[Token]>.Publisher { $tokens }

    @Published var showError: Bool = false
    var showErrorPublisher: Published<Bool>.Publisher { $showError }

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

    // MARK: - presentError
    private(set) var presentErrorCallCount = 0
    var presentErrorCompletion: (()->Void)?
    func presentError() {
        presentErrorCallCount += 1
        presentErrorCompletion?()
    }
}
