//
//  JSONDecoderTransformerTests.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import CommonKit

final class JSONDecoderTransformerTests: XCTestCase {
    var sut: JSONDecoderTransformer!
    var decoderMock: JSONDecoderMock!
    
    override func setUp() {
        super.setUp()
        decoderMock = JSONDecoderMock()
        sut = JSONDecoderTransformer(decoder: decoderMock)
    }
    
    func testTransformWithValidDataShouldReturnDecodedObject() {
        // Given
        let jsonString = """
        {
            "name": "Test",
            "value": 42
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        let expectedObject = TestModel(name: "Test", value: 42)
        decoderMock.decodeReturnValue = expectedObject
        
        // When
        let result: TestModel? = sut.transform(jsonData)
        
        // Then
        XCTAssertEqual(result, expectedObject)
        XCTAssertEqual(decoderMock.decodeCallCount, 1)
        XCTAssertEqual(decoderMock.decodeReceivedData, jsonData)
    }
    
    func testTransformWithNilDataShouldReturnNil() {
        // Given
        let nilData: Data? = nil
        
        // When
        let result: TestModel? = sut.transform(nilData)
        
        // Then
        XCTAssertNil(result)
        XCTAssertEqual(decoderMock.decodeCallCount, 0)
    }
    
    func testTransformWithEmptyDataShouldReturnNil() {
        // Given
        let emptyData = Data()
        
        // When
        let result: TestModel? = sut.transform(emptyData)
        
        // Then
        XCTAssertNil(result)
        XCTAssertEqual(decoderMock.decodeCallCount, 0)
    }
}

private struct TestModel: Decodable, Equatable {
    let name: String
    let value: Int
}
