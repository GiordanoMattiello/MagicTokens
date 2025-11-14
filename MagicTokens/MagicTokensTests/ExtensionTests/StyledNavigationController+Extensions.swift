//
//  StyledNavigationController+Extensions.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import MagicTokens

final class StyledNavigationControllerTests: XCTestCase {
    
    var sut: StyledNavigationController!
    
    override func setUp() {
        super.setUp()
        sut = StyledNavigationController()
    }
    
    func testInitWithNibNameAndBundleShouldSetupNavigationBar() {
        // Given
        // When
        let navigationController = StyledNavigationController(nibName: nil, bundle: nil)
        
        // Then
        XCTAssertNotNil(navigationController)
        XCTAssertEqual(navigationController.navigationBar.tintColor, .white)
        XCTAssertNotNil(navigationController.navigationBar.standardAppearance)
        XCTAssertNotNil(navigationController.navigationBar.scrollEdgeAppearance)
        XCTAssertNotNil(navigationController.navigationBar.compactAppearance)
    }
    
    func testSetupNavBarShouldConfigureStandardAppearance() {
        // Given
        // When - Already setup in setUp()
        
        // Then
        let standardAppearance = sut.navigationBar.standardAppearance
        XCTAssertEqual(standardAppearance.backgroundColor, .purple)
        XCTAssertEqual(standardAppearance.titleTextAttributes[.foregroundColor] as? UIColor, .white)
        XCTAssertEqual(standardAppearance.largeTitleTextAttributes[.foregroundColor] as? UIColor, .white)
    }
    
    func testSetupNavBarShouldConfigureScrollEdgeAppearance() {
        // Given
        // When - Already setup in setUp()
        
        // Then
        let scrollEdgeAppearance = sut.navigationBar.scrollEdgeAppearance
        XCTAssertEqual(scrollEdgeAppearance?.backgroundColor, .purple)
        XCTAssertEqual(scrollEdgeAppearance?.titleTextAttributes[.foregroundColor] as? UIColor, .white)
        XCTAssertEqual(scrollEdgeAppearance?.largeTitleTextAttributes[.foregroundColor] as? UIColor, .white)
    }
    
    func testSetupNavBarShouldConfigureCompactAppearance() {
        // Given
        // When - Already setup in setUp()
        
        // Then
        let compactAppearance = sut.navigationBar.compactAppearance
        XCTAssertEqual(compactAppearance?.backgroundColor, .purple)
        XCTAssertEqual(compactAppearance?.titleTextAttributes[.foregroundColor] as? UIColor, .white)
        XCTAssertEqual(compactAppearance?.largeTitleTextAttributes[.foregroundColor] as? UIColor, .white)
    }
    
    func testSetupNavBarShouldSetNavigationBarTintColor() {
        // Given
        // When - Already setup in setUp()
        
        // Then
        XCTAssertEqual(sut.navigationBar.tintColor, .white)
    }

    func testNavigationBarAppearanceShouldBeOpaque() {
        // Given
        // When - Already setup in setUp()
        
        // Then
        let standardAppearance = sut.navigationBar.standardAppearance
        XCTAssertTrue(standardAppearance.backgroundEffect == nil)
    }

    func testMultipleInstancesShouldHaveIndependentAppearance() {
        // Given
        let firstInstance = StyledNavigationController()
        let secondInstance = StyledNavigationController()
        
        // When
        // Modify one instance
        firstInstance.navigationBar.tintColor = .red
        
        // Then
        XCTAssertEqual(firstInstance.navigationBar.tintColor, .red)
        XCTAssertEqual(secondInstance.navigationBar.tintColor, .white)
    }
}
