//
//  ImageCacheProvider.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation
import UIKit

public protocol ImageCacheManagerProtocol {
    func cacheObject(data: UIImage,from key: String)
    func getCache(from key: String) -> UIImage?
}

public final class ImageCacheManager: ImageCacheManagerProtocol {
    private let imageCache = NSCache<NSString, UIImage>()
    
    public init() {}
    
    public func cacheObject(data: UIImage, from key: String) {
        imageCache.setObject(data, forKey: key as NSString)
    }
    
    public func getCache(from key: String) -> UIImage? {
        imageCache.object(forKey: key as NSString)
    }
}
