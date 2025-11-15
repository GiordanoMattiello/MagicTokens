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
    private(set) var receivedScreenModel:TokenDisplayScreenModel?
    var onCompleteConfigure: (()->Void)?
    func configure(model: TokenDisplayScreenModel) {
        configureCallCount += 1
        receivedScreenModel = model
        onCompleteConfigure?()
    }
}
