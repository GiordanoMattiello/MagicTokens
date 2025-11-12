//
//  AppCoordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit
import CommonKit

enum MagicTokenScenes {
    case tokenList
    case tokenDisplay
}

class AppCoordinator {
    var navigationController: UINavigationControllerProtocol
    var networkManager: NetworkManagerProtocol
    var jsonTransformer: DataTransformer
    var imageTransformer: DataTransformer
    var imageCacheManager: ImageCacheManagerProtocol

    init(navigationController: UINavigationControllerProtocol,
         networkManager: NetworkManagerProtocol = NetworkManager(),
         jsonTransformer: DataTransformer = JSONDecoderTransformer(),
         imageTransformer: DataTransformer = ImageDecoderTransformer(),
         imageCacheManager: ImageCacheManagerProtocol = ImageCacheManager(),
         ) {
        self.navigationController = navigationController
        self.networkManager = networkManager
        self.jsonTransformer = jsonTransformer
        self.imageTransformer = imageTransformer
        self.imageCacheManager = imageCacheManager
    }

    @MainActor
    func startApp() {
        let tokenListViewController = makeTokenListScene()
        navigationController.setViewControllers([tokenListViewController], animated: false)
    }
    
    func navigateTo(viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController,animated: animated)
    }
}
