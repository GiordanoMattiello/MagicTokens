//
//  TokenListViewControllerTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//
import XCTest
@testable import MagicTokens

final class TokenListViewControllerTests: XCTestCase {
    var sut: TokenListViewController!
    var contentViewMock: TokenListViewMock!
    var viewModelMock: TokenListViewModelMock!
    var delegateMock: TokenListViewControllerDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        contentViewMock = TokenListViewMock()
        delegateMock = TokenListViewControllerDelegateMock()
        contentViewMock.delegate = delegateMock
        viewModelMock = TokenListViewModelMock()
        sut = TokenListViewController(contentView: contentViewMock, viewModel: viewModelMock)
    }
    
    @MainActor
    func testViewDidLoadShouldSetTitleAndDelegate() async {
        // Given
        let fetchTokensExpectation = XCTestExpectation(description: "Busca os tokens no servidor")
        viewModelMock.fetchTokensCompletion = {
            fetchTokensExpectation.fulfill()
        }
        
        // When
        sut.viewDidLoad()
        
        // Then
        await fulfillment(of: [fetchTokensExpectation])
        XCTAssertEqual(sut.title, "Magic Tokens")
        XCTAssertIdentical(contentViewMock.delegate as? TokenListViewController, sut)
        XCTAssertEqual(viewModelMock.fetchTokensCallCount, 1)
        XCTAssertNotNil(viewModelMock.screenModelPublisher)
    }
    
    func testViewWillAppearShouldSetupRightBarButton() {
        // Given
        sut.loadViewIfNeeded()
        
        // When
        sut.viewWillAppear(false)
        
        // Then
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "Filtro")
    }
    
    func testRightButtonTappedShouldCallViewModelDidTapRightButton() {
        // Given
        sut.loadViewIfNeeded()
        sut.viewWillAppear(false)
        guard let rightButton = sut.navigationItem.rightBarButtonItem else {
            fatalError("TokenListViewController rightBarButtonItem nil")
        }
        
        // When
        _ = rightButton.target?.perform(rightButton.action)
        
        // Then
        XCTAssertEqual(viewModelMock.didTapRightButtonCallCount, 1)
    }
    
    func testLoadImageFromURLShouldCallViewModelLoadImageFromURL() async {
        // Given
        let url = "https://example.com/image.jpg"
        
        // When
        _ = try? await sut.loadImageFromURL(url: url)
        
        // Then
        XCTAssertEqual(viewModelMock.loadImageFromURLCallCount, 1)
        XCTAssertEqual(viewModelMock.loadImageFromURLReceivedURL, url)
    }
    
    func testFetchNextPageTokensShouldCallViewModelFetchNextPageTokens() async {
        // When
        await sut.fetchNextPageTokens()
        
        // Then
        XCTAssertEqual(viewModelMock.fetchNextPageTokensCallCount, 1)
    }
    
    func testDidSelectTokenShouldCallViewModelDidSelectToken() {
        // Given
        let token = Token.stub()
        
        // When
        sut.didSelectToken(token)
        
        // Then
        XCTAssertEqual(viewModelMock.didSelectTokenCallCount, 1)
        XCTAssertEqual(viewModelMock.didSelectTokenReceivedToken, token)
    }
    
    func testPublisherWhenTrueShouldCallPresentError() {
        // Given
        sut.viewDidLoad()
        let expectation = self.expectation(description: "Present error should be called")
        contentViewMock.configureCompletion = {
            expectation.fulfill()
        }
        
        // When
        viewModelMock.screenModel = .init(tokens: [.stub(),.stub()])
        
        // Then
        waitForExpectations()
    }
    
    @MainActor
    func testFetchTokensWithFilterShouldCallViewModelFetchTokensWithFilter() async {
        // Given
        let filterUrl = "https://api.scryfall.com/cards/search?q=power%3D5"
        let fetchTokensWithFilterExpectation = XCTestExpectation(description: "Busca tokens com filtro")
        viewModelMock.fetchTokensWithFilterCompletion = {
            fetchTokensWithFilterExpectation.fulfill()
        }
        
        // When
        sut.fetchTokensWithFilter(filterUrl: filterUrl)
        
        // Then
        await fulfillment(of: [fetchTokensWithFilterExpectation])
        XCTAssertEqual(viewModelMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertEqual(viewModelMock.fetchTokensWithFilterReceivedURL, filterUrl)
    }
    
    @MainActor
    func testFetchTokensWithFilterWithDifferentURLShouldCallViewModelWithCorrectURL() async {
        // Given
        let filterUrl = "exemple.url"
        let fetchTokensWithFilterExpectation = XCTestExpectation(description: "Busca tokens com filtro diferente")
        viewModelMock.fetchTokensWithFilterCompletion = {
            fetchTokensWithFilterExpectation.fulfill()
        }
        
        // When
        sut.fetchTokensWithFilter(filterUrl: filterUrl)
        
        // Then
        await fulfillment(of: [fetchTokensWithFilterExpectation])
        XCTAssertEqual(viewModelMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertEqual(viewModelMock.fetchTokensWithFilterReceivedURL, filterUrl)
    }
}
