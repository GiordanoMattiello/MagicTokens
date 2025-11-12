//
//  AppCoordinatorTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import XCTest
@testable import MagicTokens

final class AppCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    
    // Mocks
    var navigationControllerMock: UINavigationControllerMock!
    
    override func setUp() {
        navigationControllerMock = UINavigationControllerMock()
        
        sut = AppCoordinator(navigationController: navigationControllerMock)
    }

    func testStartSetsTokenListViewControllerAsRoot() {
        // Given

        // When
        sut.startApp()

        // Then
        XCTAssertEqual(navigationControllerMock.setViewControllersCallCount,1)
        XCTAssertNotNil(navigationControllerMock.receivedViewControllers)
        XCTAssertEqual(navigationControllerMock.receivedAnimated, false)
    }
}
