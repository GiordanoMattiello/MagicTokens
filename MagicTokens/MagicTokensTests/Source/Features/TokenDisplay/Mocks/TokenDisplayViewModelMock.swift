//
//  TokenDisplayViewModelMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

@testable import MagicTokens
import UIKit

class TokenDisplayViewModelMock: TokenDisplayViewModelProtocol {
    var token: Token = .stub()

    private(set) var loadLargeImageCallCount = 0
    var loadLargeImageReturnValue: UIImage?
    func loadLargeImage() async -> UIImage? {
        loadLargeImageCallCount += 1
        return loadLargeImageReturnValue
    }
}
