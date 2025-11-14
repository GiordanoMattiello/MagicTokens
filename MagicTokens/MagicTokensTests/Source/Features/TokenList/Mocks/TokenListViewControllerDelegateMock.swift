//
//  TokenListViewControllerDelegateMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import UIKit
@testable import MagicTokens

class TokenListViewControllerDelegateMock: TokenListViewControllerDelegate {
    private(set) var loadImageFromURLCallCount = 0
    private(set) var loadImageFromURLReceivedURL: String?
    var loadImageFromURLReturnValue: (()->UIImage?)?
    var loadImageFromURLError: Error?
    func loadImageFromURL(url: String) async throws -> UIImage? {
        loadImageFromURLCallCount += 1
        loadImageFromURLReceivedURL = url
        if let error = loadImageFromURLError {
            throw error
        }
        return loadImageFromURLReturnValue?()
    }
    
    private(set) var fetchNextPageTokensCallCount = 0
    var fetchNextPageTokensCompletion: (()->Void?)?
    func fetchNextPageTokens() async {
        fetchNextPageTokensCallCount += 1
        fetchNextPageTokensCompletion?()
    }
    
    private(set) var didSelectTokenCallCount = 0
    private(set) var didSelectTokenReceivedToken: Token?
    func didSelectToken(_ token: Token) {
        didSelectTokenCallCount += 1
        didSelectTokenReceivedToken = token
    }
}
