//
//  CoordinatorsMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

@testable import MagicTokens

final class CoordinatorsMock: TokenDisplayCoordinator, AlertErrorCoordinator, TokenFilterCoordinator {
    private(set) var navigateToTokenDisplaySceneCallCount = 0
    private(set) var receivedToken: Token?
    func navigateToTokenDisplayScene(token: Token) {
        receivedToken = token
        navigateToTokenDisplaySceneCallCount += 1
    }
    
    private(set) var presentAlertCallCount = 0
    private(set) var receivedAlertErrorModel: AlertErrorModel?
    var presentAlertCompletion: (()->Void)?
    func presentAlert(alertModel: AlertErrorModel) {
        receivedAlertErrorModel = alertModel
        presentAlertCallCount += 1
        presentAlertCompletion?()
    }
    
    private(set) var navigateToFilterSceneCallCount = 0
    private(set) var receivedFilterDelegate: ApplyFilterDelegate?
    func navigateToFilterScene(delegate: ApplyFilterDelegate?) {
        navigateToFilterSceneCallCount += 1
        receivedFilterDelegate = delegate
    }
    
    private(set) var popFilterSceneCallCount = 0
    func popFilterScene() {
        popFilterSceneCallCount += 1
    }
}
