//
//  AlertErrorCoordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

@testable import MagicTokens

final class AlertErrorCoordinatorMock: AlertErrorCoordinator {
    private(set) var presentAlertCallCount = 0
    private(set) var receivedAlertErrorModel: AlertErrorModel?
    func presentAlert(alertModel: AlertErrorModel) {
        receivedAlertErrorModel = alertModel
        presentAlertCallCount += 1
    }
}
