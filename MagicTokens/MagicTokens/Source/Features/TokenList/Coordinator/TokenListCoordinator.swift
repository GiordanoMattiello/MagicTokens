//
//  TokenList+Coordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit
import CommonKit

extension AppCoordinator {
    func makeTokenListScene() -> UIViewController {
        let adapter = TokenListAdapter()
        let view = TokenListView()
        let viewModel = TokenListViewModel(adapter: adapter,
                                           networkManager: networkManager,
                                           imageCacheManager: imageCacheManager,
                                           coordinator: self)
        return TokenListViewController(contentView: view, viewModel: viewModel)
    }
}
