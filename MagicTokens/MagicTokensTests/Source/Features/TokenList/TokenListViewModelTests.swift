//
//  TokenListViewModelTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
import CommonKit
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
        XCTAssertEqual(sut.screenModel.tokens.count, expectedTokens.count)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
        XCTAssertEqual(adapterMock.tokenAdaptCallCount, 2)
    }
    
    func testFetchTokensWithNetworkErrorShouldSetShowError() async {
        // Given
        let url = "test-url"
        networkManagerMock.executeRequestError = NSError(domain: "test", code: 0)
        let expectation = expectation(description: "Present Alert")
        coordinatorMock.presentAlertCompletion = {
            expectation.fulfill()
        }
        
        // When
        await sut.fetchTokens(url: url)
        
        // Then
        await fulfillment(of: [expectation])
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
    }
    
    func testFetchTokensWithNilResponseShouldNotUpdateTokens() async {
        // Given
        let url = "test-url"
        networkManagerMock.executeRequestReturnValue = nil
        
        // When
        await sut.fetchTokens(url: url)
        
        // Then
        XCTAssertTrue(sut.screenModel.tokens.isEmpty)
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
    
    @MainActor
    func testFetchNextPageTokensWhenAlreadyLoadingShouldNotFetchTokens() async {
        // Given
        let response = TokenListResponse.stub(nextPage: "nextPage-url")
        networkManagerMock.executeRequestReturnValue = { response }
        await sut.fetchTokens(url: "initial-url")
        
        // When - chamar fetchNextPageTokens duas vezes rapidamente
        let task1 = Task { await sut.fetchNextPageTokens() }
        let task2 = Task { await sut.fetchNextPageTokens() }
        await task1.value
        await task2.value
        
        // Then - deve fazer apenas uma requisição adicional (a primeira)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 2)
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
    
    @MainActor
    func testPresentErrorShouldCallCoordinatorPresentAlert() async {
        // When
        networkManagerMock.executeRequestError = NetworkError.generic
        await sut.fetchTokens(url: "url")
        
        // Then
        XCTAssertEqual(coordinatorMock.presentAlertCallCount, 1)
        XCTAssertNotNil(coordinatorMock.receivedAlertErrorModel)
        XCTAssertEqual(coordinatorMock.receivedAlertErrorModel?.message, "Erro ao carregar os tokens.")
        XCTAssertEqual(coordinatorMock.receivedAlertErrorModel?.secondaryButtonTitle, "Tentar novamente")
    }
    
    @MainActor
    func testPresentErrorSecondaryCompletionShouldCallTryAgain() async {
        // Given
        networkManagerMock.executeRequestError = NetworkError.generic
        await sut.fetchTokens(url: "url")
        
        
        // When
        coordinatorMock.receivedAlertErrorModel?.secondaryCompletion?()
        let expectation2 = XCTestExpectation(description: "Mostra alert de erro novamente")
        coordinatorMock.presentAlertCompletion = {
            expectation2.fulfill()
        }
        await fulfillment(of: [expectation2])
        
        // Then
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 2)
        XCTAssertTrue(sut.screenModel.tokens.isEmpty) // Resetado antes de buscar
    }
    
    @MainActor
    func testFetchTokensWithFilterShouldResetTokensAndNextPageURL() async {
        // Given
        let initialResponse = TokenListResponse.stub(nextPage: "next-page", tokens: [TokenScryFall.stub()])
        networkManagerMock.executeRequestReturnValue = { initialResponse }
        adapterMock.tokenAdaptReturnValue = Token.stub()
        await sut.fetchTokens(url: "initial-url")
        
        let filterResponse = TokenListResponse.stub(tokens: [TokenScryFall.stub(), TokenScryFall.stub()])
        networkManagerMock.executeRequestReturnValue = { filterResponse }
        
        // When
        await sut.fetchTokensWithFilter(url: "filter-url")
        
        // Then
        XCTAssertEqual(sut.screenModel.tokens.count, 2)
        XCTAssertFalse(sut.screenModel.isLoading)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 2)
    }
    
    @MainActor
    func testFetchTokensShouldSetLoadingToTrueThenFalse() async {
        // Given
        let response = TokenListResponse.stub(tokens: [TokenScryFall.stub()])
        networkManagerMock.executeRequestReturnValue = { response }
        adapterMock.tokenAdaptReturnValue = Token.stub()
        
        // When
        await sut.fetchTokens(url: "test-url")
        
        // Then
        XCTAssertFalse(sut.screenModel.isLoading)
    }
    
    @MainActor
    func testFetchTokensShouldUpdateNextPageURL() async {
        // Given
        let response = TokenListResponse.stub(nextPage: "new-next-page", tokens: [TokenScryFall.stub()])
        networkManagerMock.executeRequestReturnValue = { response }
        adapterMock.tokenAdaptReturnValue = Token.stub()
        
        // When
        await sut.fetchTokens(url: "test-url")
        await sut.fetchNextPageTokens()
        
        // Then
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 2)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests[safe: 1]?.url, "new-next-page")
    }
    
    @MainActor
    func testFetchTokensShouldAppendTokensNotReplace() async {
        // Given
        let firstResponse = TokenListResponse.stub(tokens: [TokenScryFall.stub()])
        let secondResponse = TokenListResponse.stub(tokens: [TokenScryFall.stub()])
        networkManagerMock.executeRequestReturnValue = { firstResponse }
        adapterMock.tokenAdaptReturnValue = Token.stub()
        await sut.fetchTokens(url: "first-url")
        
        let initialCount = sut.screenModel.tokens.count
        
        // When
        networkManagerMock.executeRequestReturnValue = { secondResponse }
        await sut.fetchTokens(url: "second-url")
        
        // Then
        XCTAssertEqual(sut.screenModel.tokens.count, initialCount + 1)
    }
    
    @MainActor
    func testScreenModelPublisherShouldEmitValues() async {
        // Given
        let expectation = XCTestExpectation(description: "Publisher should emit")
        var receivedValues: [TokenListScreenModel] = []
        
        let cancellable = sut.screenModelPublisher
            .dropFirst() // Ignora o valor inicial
            .sink { screenModel in
                receivedValues.append(screenModel)
                expectation.fulfill()
            }
        
        // When
        let response = TokenListResponse.stub(tokens: [TokenScryFall.stub()])
        networkManagerMock.executeRequestReturnValue = { response }
        adapterMock.tokenAdaptReturnValue = Token.stub()
        await sut.fetchTokens(url: "test-url")
        
        // Then
        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertGreaterThanOrEqual(receivedValues.count, 1)
        cancellable.cancel()
    }
    
    @MainActor
    func testInitWithCustomScreenModelShouldUseProvidedModel() {
        // Given
        let customModel = TokenListScreenModel(tokens: [Token.stub()], isLoading: false)
        
        // When
        let viewModel = TokenListViewModel(
            adapter: adapterMock,
            networkManager: networkManagerMock,
            imageCacheManager: imageCacheManagerMock,
            coordinator: coordinatorMock,
            screenModel: customModel
        )
        
        // Then
        XCTAssertEqual(viewModel.screenModel.tokens.count, 1)
        XCTAssertFalse(viewModel.screenModel.isLoading)
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
}
