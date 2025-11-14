//
//  ErrorAlertCoordinatorTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import XCTest
@testable import MagicTokens

final class ErrorAlertCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    var navigationControllerMock: UINavigationControllerMock!
    
    override func setUp() {
        super.setUp()
        navigationControllerMock = UINavigationControllerMock()
        sut = AppCoordinator(navigationController: navigationControllerMock)
    }
    
    func testPresentAlertWithSecondaryButtonShouldPresentAlertWithTwoActions() {
        // Given
        let alertModel = AlertErrorModel.stub()
        
        // When
        sut.presentAlert(alertModel: alertModel)
        
        // Then
        XCTAssertEqual(navigationControllerMock.presentCallCount, 1)
        XCTAssertTrue(navigationControllerMock.receivedViewControllerToPresent is UIAlertController)
        XCTAssertTrue(navigationControllerMock.receivedPresentAnimated == true)
        
        let alertController = navigationControllerMock.receivedViewControllerToPresent as? UIAlertController
        XCTAssertEqual(alertController?.title, "Test Title")
        XCTAssertEqual(alertController?.message, "Test Message")
        XCTAssertEqual(alertController?.preferredStyle, .alert)
        XCTAssertEqual(alertController?.actions.count, 2)
        XCTAssertEqual(alertController?.actions[safe: 0]?.title, "OK")
        XCTAssertEqual(alertController?.actions[safe: 1]?.title, "Retry")
    }
    
    func testPresentAlertWithoutSecondaryButtonShouldPresentAlertWithOneAction() {
        // Given
        let alertModel = AlertErrorModel.stub(secondaryButtonTitle: nil)
        
        // When
        sut.presentAlert(alertModel: alertModel)
        
        // Then
        XCTAssertEqual(navigationControllerMock.presentCallCount, 1)
        let alertController = navigationControllerMock.receivedViewControllerToPresent as? UIAlertController
        XCTAssertEqual(alertController?.actions.count, 1)
        XCTAssertEqual(alertController?.actions[safe: 0]?.title, "OK")
    }
    
    func testPresentAlertWhenPrimaryActionTappedShouldCallPrimaryCompletion() {
        // Given
        var completionCallCount = 0
        
        let alertModel = AlertErrorModel.stub(primaryCompletion: {
            completionCallCount += 1
        })
        
        // When
        sut.presentAlert(alertModel: alertModel)
        
        let alertController = navigationControllerMock.receivedViewControllerToPresent as? UIAlertController
        alertController?.tapButton(atIndex: 0)
        
        // Then
        XCTAssertEqual(completionCallCount,1)
    }
    
    func testPresentAlertWhenSecondaryActionTappedShouldCallSecondaryCompletion() {
        // Given
        var completionCallCount = 0
        
        let alertModel = AlertErrorModel.stub(secondaryCompletion: {
            completionCallCount += 1
        })
        
        // When
        sut.presentAlert(alertModel: alertModel)
        
        let alertController = navigationControllerMock.receivedViewControllerToPresent as? UIAlertController
        alertController?.tapButton(atIndex: 1)
        
        // Then
        XCTAssertEqual(completionCallCount,1)
    }
}
