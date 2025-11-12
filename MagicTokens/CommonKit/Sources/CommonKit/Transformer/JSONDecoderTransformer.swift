//
//  JSONDecoderTransformer.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation

public class JSONDecoderTransformer: DataTransformer {
    private let decoder: JSONDecoderProtocol
    
    public init(decoder: JSONDecoderProtocol = JSONDecoder()) {
        self.decoder = decoder
    }
    
    public func transform<T: Decodable>(_ data: Data?) -> T? {
        guard let data = data, !data.isEmpty else {
            return nil
        }
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error {
            print(error)
            return nil
        }
    }
}
