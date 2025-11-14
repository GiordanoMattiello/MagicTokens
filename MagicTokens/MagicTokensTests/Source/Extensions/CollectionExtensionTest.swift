//
//  CollectionExtensionTest.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import XCTest
@testable import MagicTokens

final class CollectionExtensionTest: XCTestCase {
    let collection = [1, 2, 3, 4, 5]
    
    func testSafeSubscriptWithValidIndexShouldReturnElement() {
        // When
        let result = collection[safe: 2]
        
        // Then
        XCTAssertEqual(result, 3)
    }
    
    func testSafeSubscriptWithIndexEqualToCountShouldReturnNil() {
        // When
        let result = collection[safe: 5]
        
        // Then
        XCTAssertNil(result)
    }
    
    func testSafeSubscriptWithNegativeIndexShouldReturnNil() {
        // When
        let result = collection[safe: -1]
        
        // Then
        XCTAssertNil(result)
    }
    
    func testSafeSubscriptWithEmptyCollectionShouldReturnNil() {
        // Given
        let emptyCollection: [Int] = []
        
        // When
        let result = emptyCollection[safe: 0]
        
        // Then
        XCTAssertNil(result)
    }
}
