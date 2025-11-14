//
//  URLSessionProtocol+Protocol.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import Foundation

public protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
