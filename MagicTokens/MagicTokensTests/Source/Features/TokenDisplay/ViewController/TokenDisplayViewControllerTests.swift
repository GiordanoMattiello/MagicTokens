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
        XCTAssertFalse(idleTimerMock.isIdleTimerDisabled)
    }
    
    
    func testLoadViewShouldSetContentViewAsView() {
        // When
        sut.loadView()
        
        // Then
        XCTAssertTrue(sut.view === viewContentMock)
    }
    
    func testTokensPublisherWhenScreenModelChange() {
        // Given
        sut.viewDidLoad()
        let expectation = expectation(description: "Update screenModel")
        viewContentMock.onCompleteConfigure = {
            expectation.fulfill()
        }
        
        // When
        viewModelMock.screenModel = .init(token: .stub())
   
        // Then
        waitForExpectations()
        XCTAssertEqual(viewContentMock.receivedScreenModel, .init(token: .stub()))
    }
}
