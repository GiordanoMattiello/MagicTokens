//
//  LoadingCoordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 15/11/25.
//

protocol LoadingCoordinator {
    func showLoading(loading: Bool)
}

extension AppCoordinator: LoadingCoordinator {
    func showLoading(loading: Bool) {
        print("-> \(loading) Loading")
    }
}
