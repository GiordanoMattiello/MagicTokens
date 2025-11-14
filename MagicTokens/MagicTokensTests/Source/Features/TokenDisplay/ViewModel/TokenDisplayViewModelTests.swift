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
    var token: Token!
    
    override func setUp() {
        super.setUp()
        networkManagerMock = NetworkServiceMock()
        sut = TokenDisplayViewModel(networkManager: networkManagerMock, token: .stub())
    }
    
    func testLoadLargeImageWhenNetworkReturnsValidDataShouldReturnUIImage() async {
        // Given
        let imageData = UIImage(systemName: "photo")?.pngData()
        networkManagerMock.executeRequestReturnValue = { imageData }
        
        // When
        let result = await sut.loadLargeImage()
        
        // Then
        guard let imageData else {
            fatalError()
        }
        
        let resultPixels = result?.pixelData()
        let expectedPixels = UIImage(data: imageData)?.pixelData()
        XCTAssertEqual(resultPixels, expectedPixels)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests.count, 1)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests[safe: 0]?.method, .get)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests[safe: 0]?.transformerType, .image)
        XCTAssertEqual(networkManagerMock.receivedExecuteRequestRequests[safe: 0]?.url, "largeImageURL")
    }
    
    func testLoadLargeImageWhenNetworkReturnsNilShouldReturnNil() async {
        // Given
        networkManagerMock.executeRequestReturnValue = nil
        
        // When
        let result = await sut.loadLargeImage()
        
        // Then
        XCTAssertNil(result)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
    }
    
    func testLoadLargeImageWithErrorWhenNetworkReturnsNilShouldReturnNil() async {
        // Given
        networkManagerMock.executeRequestReturnValue = nil
        networkManagerMock.executeRequestError = NetworkError.generic
            
        
        // When
        let result = await sut.loadLargeImage()
        
        // Then
        XCTAssertNil(result)
        XCTAssertEqual(networkManagerMock.executeRequestCallCount, 1)
    }
}
