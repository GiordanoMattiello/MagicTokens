//
//  NetworkExecutorMock.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import Foundation
@testable import CommonKit

final class NetworkExecutorMock: NetworkExecutorProtocol {
    private(set) var executeCallCount = 0
    var returnValue: Data?
    func execute(request: any NetworkRequest) async throws -> Data? {
        executeCallCount += 1
        return returnValue
    }
}
