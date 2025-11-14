//
//  TokenListDataSourceProtocolMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

@testable import MagicTokens
import UIKit

final class TokenListDataSourceProtocolMock: NSObject, TokenListDataSourceProtocol {

    // MARK: - Delegate
    var delegate: TokenListViewControllerDelegate?

    // MARK: - updateTokens
    private(set) var updateTokensCallCount = 0
    private(set) var updateTokensReceivedTokens: [Token]?
    func updateTokens(_ tokens: [Token]) {
        updateTokensCallCount += 1
        updateTokensReceivedTokens = tokens
    }

    // MARK: - UICollectionViewDataSource

    private(set) var numberOfItemsCallCount = 0
    private(set) var numberOfItemsReceivedSection: Int?
    var numberOfItemsReturnValue: Int = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItemsCallCount += 1
        numberOfItemsReceivedSection = section
        return numberOfItemsReturnValue
    }

    private(set) var cellForItemCallCount = 0
    private(set) var cellForItemReceivedArgs: (collectionView: UICollectionView, indexPath: IndexPath)?
    var cellForItemReturnValue: UICollectionViewCell = UICollectionViewCell()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForItemCallCount += 1
        cellForItemReceivedArgs = (collectionView, indexPath)
        return cellForItemReturnValue
    }

    private(set) var sizeForItemCallCount = 0
    private(set) var sizeForItemReceivedArgs: (collectionView: UICollectionView, layout: UICollectionViewLayout, indexPath: IndexPath)?
    var sizeForItemReturnValue: CGSize = .zero
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizeForItemCallCount += 1
        sizeForItemReceivedArgs = (collectionView, collectionViewLayout, indexPath)
        return sizeForItemReturnValue
    }
}
