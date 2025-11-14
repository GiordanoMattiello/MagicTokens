//
//  DependencyContainerProtocolMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import Foundation
import CommonKit
import CommonKitTestSources
@testable import MagicTokens

class DependencyContainerMock: DependencyContainerProtocol {
    
    // MARK: - makeNetworkManager
    
    private(set) var makeNetworkManagerCallCount = 0
    var makeNetworkManagerReturnValue: NetworkServiceProtocol?
    
    func makeNetworkManager() -> NetworkServiceProtocol {
        makeNetworkManagerCallCount += 1
        return makeNetworkManagerReturnValue ?? NetworkServiceMock()
    }
    
    // MARK: - makeImageCacheManager
    
    private(set) var makeImageCacheManagerCallCount = 0
    var makeImageCacheManagerReturnValue: ImageCacheManagerProtocol?
    
    func makeImageCacheManager() -> ImageCacheManagerProtocol {
        makeImageCacheManagerCallCount += 1
        return makeImageCacheManagerReturnValue ?? ImageCacheManagerMock()
    }
}
