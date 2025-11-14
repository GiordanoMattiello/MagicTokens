//
//  NetworkServiceMock.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 13/11/25.
//

import CommonKit

public class NetworkServiceMock: NetworkServiceProtocol {
    public private(set) var executeRequestCallCount = 0
    public private(set) var receivedExecuteRequestRequests: [any NetworkRequest] = []
    public var executeRequestReturnValue: (()->Any?)?
    public var executeRequestError: Error?
    public func executeRequest<T>(request: any NetworkRequest) async throws -> T? where T : Decodable {
        executeRequestCallCount += 1
        receivedExecuteRequestRequests.append(request)
        if let error = executeRequestError {
            throw error
        }
        
        if let returnValue = executeRequestReturnValue?() as? T {
            return returnValue
        }
        
        return nil
    }
    
    public init() {}
}
