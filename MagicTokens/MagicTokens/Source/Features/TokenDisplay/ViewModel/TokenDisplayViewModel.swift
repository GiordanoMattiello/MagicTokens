//
//  TokenDisplayViewModel.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import CommonKit
import UIKit

protocol TokenDisplayViewModelProtocol {
    func loadLargeImage() async -> UIImage?
    var token: Token { get }
}

final class TokenDisplayViewModel: TokenDisplayViewModelProtocol {
    private let networkManager: NetworkManagerProtocol
    let token: Token
    
    init(networkManager: NetworkManagerProtocol,
         token: Token) {
        self.networkManager = networkManager
        self.token = token
    }
    
    func loadLargeImage() async -> UIImage? {
        let request = TokenDisplayViewRequest(url: token.largeImageURL)
        let dataImage: Data? = try? await networkManager.executeRequest(request: request,
                                                            transformerType: .image)
        if let dataImage = dataImage, let image = UIImage(data: dataImage) {
            return image
        }
        return nil
    }
    
}
