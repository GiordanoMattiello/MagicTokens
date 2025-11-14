//
//  TokenList+Coordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit
import CommonKit

protocol TokenListCoordinator {
    func makeTokenListScene() -> UIViewController
}

extension AppCoordinator: TokenListCoordinator {
    func makeTokenListScene() -> UIViewController {
        let adapter = TokenListAdapter()
        let view = TokenListView()
        let viewModel = TokenListViewModel(adapter: adapter,
                                           networkManager: dependencies.makeNetworkManager(),
                                           imageCacheManager: dependencies.makeImageCacheManager(),
                                           coordinator: self)
        return TokenListViewController(contentView: view, viewModel: viewModel)
    }
}
