//
//  TokenListViewModelTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
import CommonKitTestSources
@testable import MagicTokens

final class TokenListViewModelTests: XCTestCase {
    var sut: TokenListViewModel!
    var adapterMock: TokenListAdapterMock!
    var networkManagerMock: NetworkServiceMock!
    var imageCacheManagerMock: ImageCacheManagerMock!
    var coordinatorMock: CoordinatorsMock!
    
    override func setUp() {
        super.setUp()
        adapterMock = TokenListAdapterMock()
        networkManagerMock = NetworkServiceMock()
        imageCacheManagerMock = ImageCacheManagerMock()
        coordinatorMock = CoordinatorsMock()
        sut = TokenListViewModel(
            adapter: adapterMock,
            networkManager: networkManagerMock,
            imageCacheManager: imageCacheManagerMock,
            coordinator: coordinatorMock
        )
    }
    
    func testFetchTokensWithValidURLShouldUpdateTokensAndNextPageURL() async {
        // Given
        let url = "test-url"
        let expectedTokens = [Token.stub(),Token.stub()]
        let response = TokenListResponse.stub(tokens: [TokenScryFall.stub(),TokenScryFall.stub()])
        networkManagerMock.executeRequestReturnValue = { response }
        adapterMock.tokenAdaptReturnValue = Token.stub()
        
        // When
        await sut.fetchTokens(url: url)
        
        // Then
        XCTAssertEqual(sut.tokens.count, expectedTokens.count)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
        XCTAssertEqual(adapterMock.tokenAdaptCallCount, 2)
    }
//    
    func testFetchTokensWithNetworkErrorShouldSetShowError() async {
        // Given
        let url = "test-url"
        networkManagerMock.executeRequestError = NSError(domain: "test", code: 0)
        
        // When
        await sut.fetchTokens(url: url)
        
        // Then
        XCTAssertTrue(sut.showError)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
    }
    
    func testFetchTokensWithNilResponseShouldNotUpdateTokens() async {
        // Given
        let url = "test-url"
        networkManagerMock.executeRequestReturnValue = nil
        
        // When
        await sut.fetchTokens(url: url)
        
        // Then
        XCTAssertTrue(sut.tokens.isEmpty)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
    }
    
    func testFetchNextPageTokensWithNextPageURLShouldFetchTokens() async {
        // Given
        let response = TokenListResponse.stub()
        networkManagerMock.executeRequestReturnValue = { response }
        
        // When
        await sut.fetchTokens(url: "initial-url")
        await sut.fetchNextPageTokens()
        
        // Then
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 2)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests.count, 2)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests[safe: 0]?.url, "initial-url")
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests[safe: 1]?.url, "nextPage-url")
    }
    
    func testFetchNextPageTokensWithoutNextPageURLShouldNotFetchTokens() async {
        // When
        await sut.fetchNextPageTokens()
        
        // Then
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 0)
    }
    
    func testLoadImageFromURLWithCachedImageShouldReturnCachedImage() async {
        // Given
        let url = "image-url"
        let expectedImage = UIImage(systemName: "photo")
        imageCacheManagerMock.getCacheReturnValue = expectedImage
        
        // When
        let result = await sut.loadImageFromURL(url: url)
        
        // Then
        XCTAssertEqual(result, expectedImage)
        XCTAssertEqual(imageCacheManagerMock.getCacheCallCount, 1)
        XCTAssertEqual(imageCacheManagerMock.receivedGetCacheKeys[safe: 0], url)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 0)
    }
    
    func testLoadImageFromURLWithoutCacheShouldFetchAndCacheImage() async {
        // Given
        let url = "image-url"
        let imageData: Data? = UIImage(systemName: "photo")?.pngData()
        imageCacheManagerMock.getCacheReturnValue = nil
        networkManagerMock.executeRequestReturnValue = { imageData }
        
        // When
        let result = await sut.loadImageFromURL(url: url)
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(imageCacheManagerMock.getCacheCallCount, 1)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
        XCTAssertEqual(imageCacheManagerMock.cacheObjectCallCount, 1)
        XCTAssertEqual(imageCacheManagerMock.receivedCacheObjectKeys[safe: 0], url)
    }
    
    func testLoadImageFromURLWithInvalidDataShouldReturnNil() async {
        // Given
        let url = "image-url"
        imageCacheManagerMock.getCacheReturnValue = nil
        networkManagerMock.executeRequestReturnValue = { Data() }
        
        // When
        let result = await sut.loadImageFromURL(url: url)
        
        // Then
        XCTAssertNil(result)
        XCTAssertEqual(imageCacheManagerMock.getCacheCallCount, 1)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
        XCTAssertEqual(imageCacheManagerMock.cacheObjectCallCount, 0)
    }
//    
    func testPresentErrorShouldCallCoordinatorPresentAlert() {
        // Given
        // When
        sut.presentError()
        
        // Then
        XCTAssertEqual(coordinatorMock.presentAlertCallCount, 1)
    }
    
    func testDidSelectTokenShouldCallCoordinatorNavigateToTokenDisplayScene() {
        // Given
        let token = Token.stub()
        
        // When
        sut.didSelectToken(token)
        
        // Then
        XCTAssertEqual(coordinatorMock.navigateToTokenDisplaySceneCallCount, 1)
        XCTAssertEqual(coordinatorMock.receivedToken, token)
    }
    
    func testDidTapRightButtonShouldNotCrash() {
        // Given
        // When
        sut.didTapRightButton()
        
        // Then
        // No crash expected - method should be callable
    }
    
    func testPresentErrorTapPrimaryButtonShouldSetErrorToFalse() {
        // Given
        sut.showError = true
        
        // When
        sut.presentError()
        coordinatorMock.receivedAlertErrorModel?.primaryCompletion?()
        
        // Then
        XCTAssertFalse(sut.showError)
    }
    
    @MainActor
    func testPresentErrorTapSecundaryButtonShouldSetErrorToFalseAndTryAgain() async {
        // Given
        sut.showError = true
        let expectedTokens = [Token.stub(),Token.stub()]
        let response = TokenListResponse.stub(tokens: [TokenScryFall.stub(),TokenScryFall.stub()])
        let expectation = expectation(description: "Make Request")
        networkManagerMock.executeRequestReturnValue = {
            expectation.fulfill()
            return response
        }
        adapterMock.tokenAdaptReturnValue = Token.stub()
        
        // When
        sut.presentError()
        coordinatorMock.receivedAlertErrorModel?.secondaryCompletion?()
        
        // Then
        waitForExpectations()
        XCTAssertFalse(sut.showError)
        XCTAssertEqual(sut.tokens.count, expectedTokens.count)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
        XCTAssertEqual(adapterMock.tokenAdaptCallCount, 2)
    }
    
    func testTokensPublisherShouldEmitInitialValue() {
        // Given
        let expectation = self.expectation(description: "Should emit initial value")
        var receivedTokens: [Token] = []
        
        // When
        let cancellable = sut.tokensPublisher.sink { tokens in
            receivedTokens = tokens
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations()
        XCTAssertEqual(receivedTokens, [])
        cancellable.cancel()
    }
    
    func testShowErrorPublisherShouldEmitInitialValue() {
        // Given
        let expectation = self.expectation(description: "Should emit initial value")
        var receivedShowError: Bool =  false
        
        // When
        let cancellable = sut.showErrorPublisher.sink { tokens in
            receivedShowError = false
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations()
        XCTAssertEqual(receivedShowError, false)
        cancellable.cancel()
    }
    
}
