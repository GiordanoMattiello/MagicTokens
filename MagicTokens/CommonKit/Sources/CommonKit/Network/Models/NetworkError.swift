//
//  NetworkError.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case statusError(Int)
    case unknown(Error)
    case generic
    
    init(_ error: (any Error)?) {
        if let error = error {
            self = .unknown(error)
            return
        }
        self = .generic
    }
    
    init?(_ response: URLResponse?) {
        guard let httpResponse = response as? HTTPURLResponse else {
            self = .invalidResponse
            return
            
        }
        
        guard (200..<300 ~= httpResponse.statusCode) else {
            self = .statusError(httpResponse.statusCode)
            return
        }
        
        return nil
    }
}
