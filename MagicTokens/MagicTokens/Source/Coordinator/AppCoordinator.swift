//
//  AppCoordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit

class AppCoordinator {
    private let navigationController: UINavigationControllerProtocol

    init(navigationController: UINavigationControllerProtocol) {
        self.navigationController = navigationController
    }

    func startApp() {
        let tokenListViewController = TokenListViewController()
        navigationController.setViewControllers([tokenListViewController], animated: false)
    }
}
