//
//  ImageCacheManagerMock.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 13/11/25.
//

import CommonKit
import UIKit

public final class ImageCacheManagerMock: ImageCacheManagerProtocol {
    public init() {}
    
    public private(set) var cacheObjectCallCount = 0
    public private(set) var receivedCacheObjectData: [UIImage] = []
    public private(set) var receivedCacheObjectKeys: [String] = []
    public func cacheObject(data: UIImage, from key: String) {
        cacheObjectCallCount += 1
        receivedCacheObjectData.append(data)
        receivedCacheObjectKeys.append(key)
    }
    
    public private(set) var getCacheCallCount = 0
    public private(set) var receivedGetCacheKeys: [String] = []
    public var getCacheReturnValue: UIImage?
    public func getCache(from key: String) -> UIImage? {
        getCacheCallCount += 1
        receivedGetCacheKeys.append(key)
        return getCacheReturnValue
    }
        
}
