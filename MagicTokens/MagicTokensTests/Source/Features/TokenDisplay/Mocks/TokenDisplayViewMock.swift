//
//  TokenDisplayViewMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

@testable import MagicTokens
import Foundation
import UIKit

class TokenDisplayViewMock: UIView, TokenDisplayViewProtocol {
    private(set) var configureCallCount = 0
    private(set) var receivedImage: UIImage?
    var onCompleteConfigure: (()->Void)?
    func configure(image: UIImage?) {
        configureCallCount += 1
        receivedImage = image
        onCompleteConfigure?()
    }
}
