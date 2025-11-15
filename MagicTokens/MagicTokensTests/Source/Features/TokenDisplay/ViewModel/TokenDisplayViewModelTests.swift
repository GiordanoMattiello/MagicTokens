//
//  TokenDisplayViewModelTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import XCTest
import CommonKit
import CommonKitTestSources
@testable import MagicTokens

final class TokenDisplayViewModelTests: XCTestCase {
    var sut: TokenDisplayViewModel!
    var networkManagerMock: NetworkServiceMock!
    var coordinatorMock: CoordinatorsMock!
    
    override func setUp() {
        super.setUp()
        networkManagerMock = NetworkServiceMock()
        coordinatorMock = CoordinatorsMock()
        sut = TokenDisplayViewModel(networkManager: networkManagerMock,
                                    token: .stub(),
                                    coordinator: coordinatorMock)
    }
    
    func testLoadImageWhenNetworkReturnsValidDataShouldConfigureUIImage() async {
        // Given
        let imageData = UIImage(systemName: "photo")?.pngData()
        let expectation = expectation(description: "Chama network execute")
        networkManagerMock.executeRequestReturnValue = {
            expectation.fulfill()
            return imageData
        }
        
        // When
        sut.loadImage()
        
        // Then
        guard let imageData else {
            fatalError()
        }
        
        await fulfillment(of: [expectation])
        let expectedPixels = UIImage(data: imageData)?.pixelData()
        XCTAssertEqual(sut.screenModel.image?.pixelData(),expectedPixels)
        XCTAssertFalse(sut.screenModel.isLoading)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests.count, 1)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests[safe: 0]?.method, .get)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests[safe: 0]?.transformerType, .image)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests[safe: 0]?.url, "largeImageURL")
    }
    
    @MainActor
    func testLoadImageWhenNetworkReturnsNilShouldReturnNil() async {
        // Given
        let expectation = expectation(description: "Mostra alert de erro")
        coordinatorMock.presentAlertCompletion = {
            expectation.fulfill()
        }
        
        networkManagerMock.executeRequestReturnValue = { return nil }
        
        // When
        sut.loadImage()
        
        // Then
        await fulfillment(of: [expectation])
        XCTAssertFalse(sut.screenModel.isLoading)
        XCTAssertNil(sut.screenModel.image)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
        XCTAssertEqual(coordinatorMock.presentAlertCallCount, 1)
    }
    
    func testLoadImageWithErrorWhenNetworkReturnsErrorShouldReturnNil() async {
        // Given
        networkManagerMock.executeRequestError = NetworkError.generic
        let expectation = expectation(description: "Mostra alert de erro")
        coordinatorMock.presentAlertCompletion = {
            expectation.fulfill()
        }
        
        // When
        sut.loadImage()
        
        // Then
        await fulfillment(of: [expectation])
        XCTAssertFalse(sut.screenModel.isLoading)
        XCTAssertNil(sut.screenModel.image)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
        XCTAssertEqual(coordinatorMock.presentAlertCallCount, 1)
    }
    
    func testErrorTryAgainShouldLoadImage() async {
        // Given
        networkManagerMock.executeRequestError = NetworkError.generic
        let expectation = XCTestExpectation(description: "Mostra alert de erro")
        coordinatorMock.presentAlertCompletion = {
            expectation.fulfill()
        }
        sut.loadImage()
        
        // When
        await fulfillment(of: [expectation])
        coordinatorMock.presentAlertCompletion = nil
        coordinatorMock.receivedAlertErrorModel?.secondaryCompletion?()
        
        // Then
        let expectation2 = XCTestExpectation(description: "Mostra alert de erro novamente")
        coordinatorMock.presentAlertCompletion = {
            expectation2.fulfill()
        }
        await fulfillment(of: [expectation2])
        XCTAssertFalse(sut.screenModel.isLoading)
        XCTAssertNil(sut.screenModel.image)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 2)
    }
}
