//
//  ImageDecoderTransformer.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit

public struct ImageDecoderTransformer: DataTransformer {
    
    public init() {}
    
    public func transform<T: Decodable>(_ data: Data?) -> T? {
        return data as? T
    }
}
