//
//  JSONDecoderMock.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import Foundation
@testable import CommonKit

final class JSONDecoderMock: JSONDecoderProtocol {
    var decodeCallCount = 0
    var decodeReceivedType: Any.Type?
    var decodeReceivedData: Data?
    var decodeReturnValue: Any?
    var decodeError: Error?
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        decodeCallCount += 1
        decodeReceivedType = type
        decodeReceivedData = data
        
        if let error = decodeError {
            throw error
        }
        
        if let returnValue = decodeReturnValue as? T {
            return returnValue
        } else {
            throw NSError(domain: "Mock", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not cast return value to expected type"])
        }
    }
}
