//
//  TokenListCellMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

@testable import MagicTokens
import UIKit

final class TokenListCellMock: UICollectionViewCell, TokenListCellProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private(set) var configureCallCount: Int = 0
    private(set) var receivedImage: UIImage?
    var configureCompletion: (()->Void)?
    func configure(with image: UIImage?) {
        configureCallCount += 1
        receivedImage = image
        configureCompletion?()
    }
}
