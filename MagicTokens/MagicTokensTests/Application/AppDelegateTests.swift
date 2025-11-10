//
//  AppDelegateTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import XCTest
@testable import MagicTokens

final class AppDelegateTests: XCTestCase {
    var sut: AppDelegate!
    
    // Mocks
    var navigationControllerMock: UINavigationControllerMock!
    
    override func setUp() {
        navigationControllerMock = UINavigationControllerMock()
        
        sut = AppDelegate()
    }

    func testStartApp() {
        // Given
        let application = UIApplication.shared

        // When
        let returnValue = sut.application(application, didFinishLaunchingWithOptions: nil)

        // Then
        XCTAssertTrue(returnValue)
    }
    
    func testSupportedInterfaceOrientations() {
        // Given
        let application = UIApplication.shared
        let window = UIWindow()

        // When
        let returnValue = sut.application(application, supportedInterfaceOrientationsFor: window)

        // Then
        XCTAssertEqual(returnValue, UIInterfaceOrientationMask.portrait)
    }
}
