//
//  TokenDisplayCoordinatorTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenDisplayCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    var navigationControllerMock: UINavigationControllerMock!
    var dependenciesMock: DependencyContainerMock!
    
    override func setUp() {
        super.setUp()
        navigationControllerMock = UINavigationControllerMock()
        dependenciesMock = DependencyContainerMock()
        sut = AppCoordinator(navigationController: navigationControllerMock, dependencies: dependenciesMock)
    }
    
    func testNavigateToTokenDisplayScenePushesViewController() {
        // Given
        let token = Token.stub()
        
        // When
        sut.navigateToTokenDisplayScene(token: token)
        
        // Then
        XCTAssertEqual(navigationControllerMock.pushViewControllerCallCount, 1)
        XCTAssertTrue(navigationControllerMock.receivedPushViewController is TokenDisplayViewController)
        XCTAssertEqual(navigationControllerMock.receivedPushAnimated, true)
        XCTAssertEqual(dependenciesMock.makeNetworkManagerCallCount, 1)
    }
}
