//
//  TokenDisplayCoordinatorMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

@testable import MagicTokens

final class TokenDisplayCoordinatorMock: TokenDisplayCoordinator {
    private(set) var navigateToTokenDisplaySceneCallCount = 0
    private(set) var receivedToken: Token?
    func navigateToTokenDisplayScene(token: Token) {
        receivedToken = token
        navigateToTokenDisplaySceneCallCount += 1
    }
}
