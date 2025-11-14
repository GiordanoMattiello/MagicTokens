//
//  AppCoordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit
import CommonKit

class AppCoordinator {
    var navigationController: UINavigationControllerProtocol
    let dependencies: DependencyContainerProtocol
    
    init(navigationController: UINavigationControllerProtocol,
         dependencies: DependencyContainerProtocol = DependencyContainer()) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    @MainActor
    func startApp() {
        let tokenListViewController = makeTokenListScene()
        navigationController.setViewControllers([tokenListViewController], animated: false)
    }
}
