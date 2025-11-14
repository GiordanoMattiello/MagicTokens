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
    var windowMock: UIWindowProtocolMock!
    
    override func setUp() {
        windowMock = UIWindowProtocolMock()
        
        sut = AppDelegate()
    }

    func testStartApp() {
        // Given
        let application = UIApplication.shared
        sut.appCoordinator = nil
        windowMock.rootViewController = nil
        sut.window = windowMock

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
