//
//  TokenDisplayViewControllerTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenDisplayViewControllerTests: XCTestCase {
    var sut: TokenDisplayViewController!
    var viewContentMock: TokenDisplayViewMock!
    var viewModelMock: TokenDisplayViewModelMock!
    var idleTimerMock: IdleTimerMock!
    
    override func setUp() {
        super.setUp()
        viewContentMock = TokenDisplayViewMock()
        viewModelMock = TokenDisplayViewModelMock()
        idleTimerMock = IdleTimerMock()
        sut = TokenDisplayViewController(contentView: viewContentMock, viewModel: viewModelMock, idleTimer: idleTimerMock)
    }
    
    func testViewDidLoadShouldSetNavigationTitle() {
        // Given
        let navigationControllerMock = UINavigationController(rootViewController: sut)
        viewModelMock.token = Token.stub()
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.title, "Token name")
        XCTAssertEqual(navigationControllerMock.navigationBar.topItem?.backButtonTitle, "")
    }
    
    func testViewWillAppearShouldDisableIdleTimerAndShouldLoadImage() {
        // When
        sut.viewWillAppear(true)
        
        // Then
        XCTAssertTrue(idleTimerMock.isIdleTimerDisabled)
    }
    
    func testViewWillDisappearShouldEnableIdleTimer() {
        // When
        sut.viewWillDisappear(true)
        
        // Then
        XCTAssertFalse(idleTimerMock.isIdleTimerDisabled)
    }
    
    func testDeinitEnableIdleTimer() {
        // When
        sut = nil
        
        // Then
        XCTAssertFalse(idleTimerMock.isIdleTimerDisabled)
    }
    
    func testViewWillAppearThenViewWillDisappearShouldEnableIdleTimer() {
        // Given
        sut.viewWillAppear(true)
        
        // When
        sut.viewWillDisappear(true)
        
        // Then
        XCTAssertFalse(UIApplication.shared.isIdleTimerDisabled)
    }
    
    
    func testLoadViewShouldSetContentViewAsView() {
        // When
        sut.loadView()
        
        // Then
        XCTAssertTrue(sut.view === viewContentMock)
    }
    
    @MainActor
    func testLoadImageShouldConfigureContentViewWithImage() async {
        // Given
        let expectation = expectation(description: "A imagem deve ser carregada e configurada")
        
        let expectedImage = UIImage(systemName: "photo")
        viewModelMock.loadLargeImageReturnValue = expectedImage
        viewContentMock.onCompleteConfigure = {
            expectation.fulfill()
        }
        
        // When
        sut.viewWillAppear(true)
        
        await fulfillment(of: [expectation])
        XCTAssertEqual(viewContentMock.configureCallCount, 1)
        XCTAssertEqual(viewModelMock.loadLargeImageCallCount, 1)
        XCTAssertEqual(viewContentMock.receivedImage, expectedImage)
    }
}
