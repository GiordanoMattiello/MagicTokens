//
//  DataTransformer.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation

public protocol DataTransformer {
    func transform<T: Decodable>(_ data: Data?) -> T?
}
