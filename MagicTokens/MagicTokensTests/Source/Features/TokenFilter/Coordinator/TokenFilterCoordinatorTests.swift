//
//  TokenFilterCoordinatorTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenFilterCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    var navigationControllerMock: UINavigationControllerMock!
    var dependenciesMock: DependencyContainerMock!
    
    override func setUp() {
        super.setUp()
        navigationControllerMock = UINavigationControllerMock()
        dependenciesMock = DependencyContainerMock()
        sut = AppCoordinator(navigationController: navigationControllerMock, dependencies: dependenciesMock)
    }
    
    func testNavigateToFilterSceneWithDelegatePushesViewController() {
        // Given
        let delegateMock = ApplyFilterDelegateMock()
        
        // When
        sut.navigateToFilterScene(delegate: delegateMock)
        
        // Then
        XCTAssertEqual(navigationControllerMock.pushViewControllerCallCount, 1)
        XCTAssertTrue(navigationControllerMock.receivedPushViewController is TokenFilterViewController)
        XCTAssertEqual(navigationControllerMock.receivedPushAnimated, true)
    }
    
    func testPopFilterScenePopsViewController() {
        // Given
        sut.navigateToFilterScene(delegate: ApplyFilterDelegateMock())
        navigationControllerMock.topViewController = navigationControllerMock.receivedPushViewController
        
        // When
        sut.popFilterScene()
        
        // Then
        XCTAssertEqual(navigationControllerMock.popViewControllerCallCount, 1)
        XCTAssertEqual(navigationControllerMock.receivedPopAnimated, true)
    }
    
    func testNavigateToFilterSceneWithoutDelegatePushesViewController() {
        // Given
        
        // When
        sut.navigateToFilterScene(delegate: nil)
        
        // Then
        XCTAssertEqual(navigationControllerMock.pushViewControllerCallCount, 1)
        XCTAssertTrue(navigationControllerMock.receivedPushViewController is TokenFilterViewController)
        XCTAssertEqual(navigationControllerMock.receivedPushAnimated, true)
    }
    
    func testNavigateToFilterSceneCreatesTokenFilterViewController() {
        // Given
        let delegateMock = ApplyFilterDelegateMock()
        
        // When
        sut.navigateToFilterScene(delegate: delegateMock)
        
        // Then
        let viewController = navigationControllerMock.receivedPushViewController
        XCTAssertTrue(viewController is TokenFilterViewController)
    }
}

