//
//  NetworkExecutor.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation

public protocol NetworkExecutorProtocol {
    func execute(request: any NetworkRequest) async throws -> Data?
}

public final class NetworkExecutor: NetworkExecutorProtocol {
    private let session: URLSessionProtocol

    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func execute(request: any NetworkRequest) async throws -> Data? {
        guard let urlRequest = makeURLRequest(request.url, request.method.rawValue) else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, response) = try await session.data(for: urlRequest, delegate: nil)
            if let error = NetworkError(response) {
                throw error
            }
            
            return data
        } catch let error {
            if error is NetworkError {
                throw error
            }
            throw NetworkError(error)
        }
        
    }
    
    private func makeURLRequest(_ url: String,_ method: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        return urlRequest
    }
}
