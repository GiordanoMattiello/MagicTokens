//
//  NetworkServiceTests.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import CommonKit

final class NetworkServiceTests: XCTestCase {
    var sut: NetworkService!
    var executorMock: NetworkExecutorMock!
    var jsonTransformerMock: DataTransformerMock!
    var imageTransformerMock: DataTransformerMock!
    
    override func setUp() {
        super.setUp()
        executorMock = NetworkExecutorMock()
        jsonTransformerMock = DataTransformerMock()
        imageTransformerMock = DataTransformerMock()
        sut = NetworkService(
            executor: executorMock,
            jsonTransformer: jsonTransformerMock,
            imageTransformer: imageTransformerMock
        )
    }
    
    func testExecuteRequestWithJSONTransformerShouldUseJSONTransformer() async {
        // Given
        let request = NetworkRequestMock()
        let expectedData = "test".data(using: .utf8)!
        let expectedResult = "test"
        
        executorMock.returnValue = expectedData
        jsonTransformerMock.returnValue = "test"
        
        // When
        do {
            let result: String? = try await sut.executeRequest(request: request)
            
            // Then
            XCTAssertEqual(result, expectedResult)
            XCTAssertEqual(executorMock.executeCallCount, 1)
            XCTAssertEqual(jsonTransformerMock.transformCallCount, 1)
            XCTAssertEqual(imageTransformerMock.transformCallCount, 0)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }
    
    func testExecuteRequestWithImageTransformerShouldUseImageTransformer() async {
        // Given
        let request = NetworkRequestMock(transformerType: .image)
        let imageData = UIImage(systemName: "star")?.pngData()!
        
        executorMock.returnValue = imageData
        imageTransformerMock.returnValue = imageData
        
        // When
        do {
            let result: Data? = try await sut.executeRequest(request: request)
            
            // Then
            XCTAssertEqual(result, imageData)
            XCTAssertEqual(executorMock.executeCallCount, 1)
            XCTAssertEqual(imageTransformerMock.transformCallCount, 1)
            XCTAssertEqual(jsonTransformerMock.transformCallCount, 0)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }
}
