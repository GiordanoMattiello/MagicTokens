//
//  NetworkService.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation

public protocol NetworkServiceProtocol {
    func executeRequest<T: Decodable>(request: any NetworkRequest) async throws -> T?
}

public final class NetworkService: NetworkServiceProtocol {
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
    
    public func executeRequest<T: Decodable>(request: any NetworkRequest) async throws -> T? {
        let transformer: DataTransformer
        switch request.transformerType {
        case .json:
            transformer = jsonTransformer
        case .image:
            transformer = imageTransformer
        }
        let data = try await executor.execute(request: request)
        return transformer.transform(data)
    }
}
