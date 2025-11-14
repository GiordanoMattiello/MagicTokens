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
    var dependencyMock: DependencyContainerMock!
    
    override func setUp() {
        navigationControllerMock = UINavigationControllerMock()
        
        sut = AppCoordinator(navigationController: navigationControllerMock)
    }
    
    @MainActor
    func testStartSetsTokenListViewControllerAsRoot() {
        // When
        sut.startApp()
        
        // Then
        XCTAssertEqual(navigationControllerMock.setViewControllersCallCount, 1)
        XCTAssertTrue(navigationControllerMock.receivedSetViewControllers?.first is TokenListViewController)
    }
}
