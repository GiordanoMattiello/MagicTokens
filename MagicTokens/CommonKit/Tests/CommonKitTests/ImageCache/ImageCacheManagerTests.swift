//
//  ImageCacheManagerTests.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import CommonKit

final class ImageCacheManagerTests: XCTestCase {
    var sut: ImageCacheManager!
    
    override func setUp() {
        super.setUp()
        sut = ImageCacheManager()
    }
    
    func testCacheObjectShouldStoreImageInCache() {
        // Given
        let key = "test-image-key"
        guard let image = UIImage(systemName: "photo") else {fatalError()}
        
        // When
        sut.cacheObject(data: image, from: key)
        
        // Then
        let cachedImage = sut.getCache(from: key)
        XCTAssertEqual(cachedImage, image)
    }
    
    func testGetCacheWithNonExistentKeyShouldReturnNil() {
        // Given
        let nonExistentKey = "non-existent-key"
        
        // When
        let result = sut.getCache(from: nonExistentKey)
        
        // Then
        XCTAssertNil(result)
    }
    
    func testCacheObjectWithSameKeyShouldOverridePreviousImage() {
        // Given
        let key = "same-key"
        guard let firstImage = UIImage(systemName: "photo") else {fatalError()}
        guard let secondImage = UIImage(systemName: "square.and.arrow.up.circle.fill") else {fatalError()}
        
        // When
        sut.cacheObject(data: firstImage, from: key)
        sut.cacheObject(data: secondImage, from: key)
        
        // Then
        let cachedImage = sut.getCache(from: key)
        XCTAssertEqual(cachedImage, secondImage)
    }
    
    func testCacheObjectWithDifferentKeysShouldStoreSeparateImages() {
        // Given
        let key1 = "key-one"
        let key2 = "key-two"
        guard let firstImage = UIImage(systemName: "photo") else {fatalError()}
        guard let secondImage = UIImage(systemName: "square.and.arrow.up.circle.fill") else {fatalError()}
        
        // When
        sut.cacheObject(data: firstImage, from: key1)
        sut.cacheObject(data: secondImage, from: key2)
        
        // Then
        XCTAssertEqual(sut.getCache(from: key1), firstImage)
        XCTAssertEqual(sut.getCache(from: key2), secondImage)
    }
    
    func testGetCacheAfterCacheObjectShouldReturnSameInstance() {
        // Given
        let key = "test-key"
        guard let image = UIImage(systemName: "photo") else {fatalError()}
        
        // When
        sut.cacheObject(data: image, from: key)
        let retrievedImage = sut.getCache(from: key)
        
        // Then
        XCTAssertIdentical(image, retrievedImage)
    }
}
