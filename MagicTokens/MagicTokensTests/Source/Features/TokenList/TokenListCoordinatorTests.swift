//
//  TokenListCoordinatorTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenListCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    var navigationControllerMock: UINavigationControllerMock!
    var dependenciesMock: DependencyContainerMock!
    
    override func setUp() {
        super.setUp()
        navigationControllerMock = UINavigationControllerMock()
        dependenciesMock = DependencyContainerMock()
        sut = AppCoordinator(navigationController: navigationControllerMock, dependencies: dependenciesMock)
    }
    
    func testMakeTokenListScene() {
        // When
        let viewController = sut.makeTokenListScene()
        
        // Then
        XCTAssertTrue(viewController is TokenListViewController)
        XCTAssertEqual(dependenciesMock.makeNetworkManagerCallCount, 1)
        XCTAssertEqual(dependenciesMock.makeImageCacheManagerCallCount, 1)
    }
}
