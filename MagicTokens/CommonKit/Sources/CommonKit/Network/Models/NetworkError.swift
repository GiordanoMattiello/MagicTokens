//
//  NetworkError.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation

public enum NetworkError: Error, Equatable {
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
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
            switch (lhs, rhs) {
            case (.invalidURL, .invalidURL):
                return true
            case (.invalidResponse, .invalidResponse):
                return true
            case (.decodingFailed, .decodingFailed):
                return true
            case (.statusError(let lhsCode), .statusError(let rhsCode)):
                return lhsCode == rhsCode
            case (.generic, .generic):
                return true
            case (.unknown, .unknown):
                return lhs.localizedDescription == rhs.localizedDescription
            default:
                return false
            }
        }
}
