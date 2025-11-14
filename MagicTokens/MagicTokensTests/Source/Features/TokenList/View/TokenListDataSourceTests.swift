//
//  TokenListDataSourceTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenListDataSourceTests: XCTestCase {
    var sut: TokenListDataSource!
    var delegateMock: TokenListViewControllerDelegateMock!
    var collectionViewMock: UICollectionViewMock!
    
    override func setUp() {
        super.setUp()
        delegateMock = TokenListViewControllerDelegateMock()
        collectionViewMock = UICollectionViewMock()
        sut = TokenListDataSource()
        sut.delegate = delegateMock
        collectionViewMock.delegate = sut
    }
     
    func testCollectionViewNumberOfItemsInSectionReturnsTokenCount() {
        // Given
        let testTokens: [Token] = [.stub(), .stub(), .stub()]
        sut.updateTokens(testTokens)
        
        // When
        let count = sut.collectionView(collectionViewMock, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertEqual(count, 3)
    }
    
    func testCollectionViewCellForItemAtDequeuesUICollectionViewCell() {
        // Given
        let testTokens: [Token] = [.stub()]
        sut.updateTokens(testTokens)
        let indexPath = IndexPath(item: 0, section: 0)
        
        // When
        let cell = sut.collectionView(collectionViewMock, cellForItemAt: indexPath)

        // Then
        XCTAssertEqual(collectionViewMock.dequeueReusableCellCallCount, 1)
        XCTAssertEqual(collectionViewMock.receivedReuseIdentifier, "TokenListCell")
        XCTAssertEqual(collectionViewMock.receivedIndexPath, indexPath)
        XCTAssertFalse(cell is UICollectionViewCellMock)
    }

    @MainActor
    func testCollectionViewCellForItemAtDequeuesTokenListCell() async {
        // Given
        sut.updateTokens([.stub(),.stub()])
        
        // Cell Mock
        let cellMock = TokenListCellMock()
        let cellConfiguredExpectation = XCTestExpectation(description: "cell configure called")
        cellMock.configureCompletion = {
            cellConfiguredExpectation.fulfill()
        }
        collectionViewMock.dequeueReusableCellReturnValue = cellMock
        
        // imageLoad mock
        let loadImageExpectation = XCTestExpectation(description: "A imagem deve ser carregada e configurada")
        delegateMock.loadImageFromURLReturnValue = {
            loadImageExpectation.fulfill()
            return UIImage(systemName: "photo")
        }

        // When
        let cell = sut.collectionView(collectionViewMock, cellForItemAt:  IndexPath(item: 0, section: 0))

        // Then
        await fulfillment(of: [loadImageExpectation, cellConfiguredExpectation])
        
        XCTAssertEqual(collectionViewMock.dequeueReusableCellCallCount, 1)
        XCTAssertEqual(collectionViewMock.receivedReuseIdentifier, "TokenListCell")
        XCTAssertEqual(collectionViewMock.receivedIndexPath, IndexPath(item: 0, section: 0))
        guard let cell = cell as? TokenListCellMock else {
            XCTFail("Célula não é TokenListCellMock")
            return
        }
        XCTAssertEqual(cell.configureCallCount,1)
        XCTAssertEqual(cell.receivedImage, UIImage(systemName: "photo"))
    }

    @MainActor
    func testCollectionViewCellForItemAtLastItemTriggersFetchNextPage() async {
        // Given
        let testTokens: [Token] = [.stub(), .stub()]
        sut.updateTokens(testTokens)
        collectionViewMock.dequeueReusableCellReturnValue = TokenListCellMock()
        let indexPath = IndexPath(item: 1, section: 0)
        let fetchNextPageTokensExpectation = XCTestExpectation(description: "A proxima pagina deve ser carregada")
        delegateMock.fetchNextPageTokensCompletion = {
            fetchNextPageTokensExpectation.fulfill()
        }
        
        // When
        _ = sut.collectionView(collectionViewMock, cellForItemAt: indexPath)

        // Then
        await fulfillment(of: [fetchNextPageTokensExpectation], timeout: 1.0)
        XCTAssertEqual(delegateMock.fetchNextPageTokensCallCount, 1)
    }
//    
    func testCollectionViewDidSelectItemAtCallsDelegate() {
        // Given
        sut.updateTokens([Token.stub()])
        let indexPath = IndexPath(item: 0, section: 0)
        
        // When
        sut.collectionView(collectionViewMock, didSelectItemAt: indexPath)

        // Then
        XCTAssertEqual(delegateMock.didSelectTokenCallCount, 1)
        XCTAssertEqual(delegateMock.didSelectTokenReceivedToken, .stub())
    }
    
    func testCollectionViewSizeForItemAtReturnsCorrectSize() {
        // Given
        let indexPath = IndexPath(item: 0, section: 0)
        
        // When
        let size = sut.collectionView(collectionViewMock, layout: UICollectionViewFlowLayout(), sizeForItemAt: indexPath)

        // Then
        XCTAssertEqual(size.width, 146)
        XCTAssertEqual(size.height, 146 / 0.71568627451)
    }
}
