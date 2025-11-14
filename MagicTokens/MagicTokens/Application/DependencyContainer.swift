//
//  DependencyContainer.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import CommonKit

protocol DependencyContainerProtocol {
    func makeNetworkManager() -> NetworkServiceProtocol
    func makeImageCacheManager() -> ImageCacheManagerProtocol
}

class DependencyContainer: DependencyContainerProtocol {
    private lazy var sharedNetworkManager: NetworkServiceProtocol = NetworkService()
    private lazy var sharedImageCacheManager: ImageCacheManagerProtocol = ImageCacheManager()
    
    func makeNetworkManager() -> NetworkServiceProtocol {
        return sharedNetworkManager
    }
    
    func makeImageCacheManager() -> ImageCacheManagerProtocol {
        return sharedImageCacheManager
    }
}
