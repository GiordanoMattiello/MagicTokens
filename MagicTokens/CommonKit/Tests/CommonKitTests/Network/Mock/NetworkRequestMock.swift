//
//  NetworkRequestMock.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import CommonKit

struct NetworkRequestMock: NetworkRequest {
    let url: String
    let method: NetworkMethod
    let transformerType: TransformerType
    
    init( url: String = "url",
          method: NetworkMethod = .get,
          transformerType: TransformerType = .json) {
        self.url = url
        self.method = method
        self.transformerType = transformerType
    }
}
