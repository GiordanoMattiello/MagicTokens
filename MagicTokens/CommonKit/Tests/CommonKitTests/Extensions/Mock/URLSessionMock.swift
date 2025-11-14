//
//  URLSessionMock.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import CommonKit

public class URLSessionMock: URLSessionProtocol {
    private(set) var dataForCallCount = 0
    private(set) var dataForReceivedRequest: URLRequest?
    var dataForReturnValue: (Data, URLResponse) = (Data(), HTTPURLResponse())
    var dataForError: Error?
    
    public func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        dataForCallCount += 1
        dataForReceivedRequest = request
        
        if let error = dataForError {
            throw error
        }
        
        return dataForReturnValue
    }
}
