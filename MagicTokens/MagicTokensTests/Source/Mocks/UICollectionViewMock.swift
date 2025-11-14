//
//  UICollectionViewMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import MagicTokens

final class UICollectionViewMock: UICollectionView {
    var dequeueReusableCellCallCount = 0
    var receivedReuseIdentifier: String?
    var receivedIndexPath: IndexPath?
    var dequeueReusableCellReturnValue: UICollectionViewCell?
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        dequeueReusableCellCallCount += 1
        receivedReuseIdentifier = identifier
        receivedIndexPath = indexPath
        return dequeueReusableCellReturnValue ?? UICollectionViewCellMock()
    }
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class UICollectionViewCellMock: UICollectionViewCell {}
