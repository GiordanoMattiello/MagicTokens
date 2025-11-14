//
//  ImageDecoderTransformerTests.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import CommonKit

final class ImageDecoderTransformerTests: XCTestCase {
    var sut: ImageDecoderTransformer!
    
    override func setUp() {
        super.setUp()
        sut = ImageDecoderTransformer()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTransformWithImageDataShouldReturnData() {
        // Given
        let imageData = UIImage(systemName: "star")?.pngData()
        
        // When
        let result: Data? = sut.transform(imageData)
        
        // Then
        XCTAssertEqual(result, imageData)
    }
    
    func testTransformWithNilDataShouldReturnNil() {
        // Given
        let nilData: Data? = nil
        
        // When
        let result: Data? = sut.transform(nilData)
        
        // Then
        XCTAssertNil(result)
    }
}
