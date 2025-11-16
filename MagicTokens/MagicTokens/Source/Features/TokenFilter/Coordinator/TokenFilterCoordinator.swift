//
//  TokenFilterCoordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit
import CommonKit

protocol TokenFilterCoordinator {
    func navigateToFilterScene(delegate: ApplyFilterDelegate?)
    func popFilterScene()
}

extension AppCoordinator: TokenFilterCoordinator {
    func navigateToFilterScene(delegate: ApplyFilterDelegate?) {
        navigationController.pushViewController(makeTokenFilterScene(delegate: delegate), animated: true)
    }
    
    func popFilterScene() {
        if navigationController.topViewController is TokenFilterViewController {
            navigationController.popViewController(animated: true)
        }
    }
    
    private func makeTokenFilterScene(delegate: ApplyFilterDelegate?) -> UIViewController {
        let view = TokenFilterView()
        let viewModel = TokenFilterViewModel(coordinator: self, delegate: delegate)
        return TokenFilterViewController(contentView: view, viewModel: viewModel)
    }
}

