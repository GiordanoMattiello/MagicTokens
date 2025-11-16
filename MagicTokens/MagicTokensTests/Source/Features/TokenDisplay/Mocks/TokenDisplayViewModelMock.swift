//
//  TokenDisplayViewModelMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

@testable import MagicTokens
import UIKit

class TokenDisplayViewModelMock: TokenDisplayViewModelProtocol {
    private(set) var loadLargeImageCallCount = 0
    func loadImage() {
        loadLargeImageCallCount += 1
    }
    
    @Published var screenModel: TokenDisplayScreenModel = TokenDisplayScreenModel(token: .stub())
    var screenModelPublisher: Published<MagicTokens.TokenDisplayScreenModel>.Publisher {$screenModel}
}
