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
        XCTAssertNotNil(viewModelMock.tokensPublisher)
        XCTAssertNotNil(viewModelMock.showErrorPublisher)
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
    
    func testShowErrorPublisherWhenTrueShouldCallPresentError() {
        // Given
        sut.viewDidLoad()
        let expectation = self.expectation(description: "Present error should be called")
        viewModelMock.presentErrorCompletion = {
            expectation.fulfill()
        }
        
        // When
        viewModelMock.showError = true
        
        // Then
        waitForExpectations()
        XCTAssertEqual(viewModelMock.presentErrorCallCount, 1)
    }
    
    func testShowErrorPublisherWhenFalseShouldNotCallPresentError() {
        // Given
        sut.viewDidLoad()
        let expectation = expectation(description: "Present error should be called")
        expectation.isInverted = true
        viewModelMock.presentErrorCompletion = {
            expectation.fulfill()
        }
        
        // When
        viewModelMock.showError = false
        
        // Then
        wait(for: [expectation],timeout: 0.1)
        XCTAssertEqual(viewModelMock.presentErrorCallCount, 0)
    }
    
    func testTokensPublisherWhenTokenArrayChange() {
        // Given
        let tokensMock: [Token] = [.stub(),.stub(),.stub(),.stub()]
        sut.viewDidLoad()
        let expectation = expectation(description: "Update Tokens")
        contentViewMock.updateTokensCompletion = {
            expectation.fulfill()
        }
        
        // When
        viewModelMock.tokens = tokensMock
   
        // Then
        waitForExpectations()
        XCTAssertEqual(contentViewMock.updateTokensReceivedTokens, tokensMock)
    }
}
