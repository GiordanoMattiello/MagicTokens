//
//  NetworkManager.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation

public protocol NetworkManagerProtocol {
    func executeRequest<T: Decodable>(request: any NetworkRequest,
                                      transformerType: TransformerType) async throws -> T?
}

public struct NetworkManager: NetworkManagerProtocol {
    private let executor: NetworkExecutorProtocol
    private let jsonTransformer: DataTransformer
    private let imageTransformer: DataTransformer
    
    public init(executor: NetworkExecutorProtocol = NetworkExecutor(),
                jsonTransformer: DataTransformer = JSONDecoderTransformer(),
                imageTransformer: DataTransformer = ImageDecoderTransformer()) {
        self.executor = executor
        self.jsonTransformer = jsonTransformer
        self.imageTransformer = imageTransformer
    }
    
    public func executeRequest<T: Decodable>(request: any NetworkRequest,
                                             transformerType: TransformerType = .json) async throws -> T? {
        let transformer: DataTransformer
        switch transformerType {
        case .json:
            transformer = jsonTransformer
        case .image:
            transformer = imageTransformer
        }
        let data = try await executor.execute(request: request)
        
        return transformer.transform(data)
    }
}
