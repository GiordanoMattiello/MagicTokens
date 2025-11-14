//
//  DataTransformerMock.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import Foundation
@testable import CommonKit

final class DataTransformerMock: DataTransformer {
    private(set) var transformCallCount = 0
    var returnValue: Any?
    
    func transform<T>(_ data: Data?) -> T? where T : Decodable {
        transformCallCount += 1
        return returnValue as? T
    }
}
