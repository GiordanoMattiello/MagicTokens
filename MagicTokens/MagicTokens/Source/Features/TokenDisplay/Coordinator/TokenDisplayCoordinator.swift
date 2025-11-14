//
//  TokenDisplay+Coordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit
import CommonKit

protocol TokenDisplayCoordinator {
    func navigateToTokenDisplayScene(token: Token)
}

extension AppCoordinator: TokenDisplayCoordinator {
    func navigateToTokenDisplayScene(token: Token) {
        navigationController.pushViewController(makeTokenDisplayScene(token: token), animated: true)
    }
    
    private func makeTokenDisplayScene(token: Token) -> UIViewController {
        let view = TokenDisplayView()
        let viewModel = TokenDisplayViewModel(networkManager: dependencies.makeNetworkManager(),
                                              token: token)
        return TokenDisplayViewController(contentView: view,
                                          viewModel: viewModel)
    }
}
