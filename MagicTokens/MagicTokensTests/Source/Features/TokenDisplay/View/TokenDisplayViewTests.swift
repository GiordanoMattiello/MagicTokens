//
//  TokenDisplayViewTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenDisplayViewTests: XCTestCase {
    var sut: TokenDisplayView!
    
    override func setUp() {
        super.setUp()
        sut = TokenDisplayView()
    }
    
    func testInitShouldSetupSubviews() {
        // Given
        let imageView = sut.findView(withAccessibilityIdentifier: "imageView") as? UIImageView
        
        // Then
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.backgroundColor, .systemBackground)
        XCTAssertEqual(imageView?.contentMode, .scaleAspectFit)
        XCTAssertEqual(imageView?.backgroundColor, .systemBackground)
    }
    
    func testConfigureWithNilImageShouldSetImageViewImageToNil() {
        // Given
        let imageView = sut.findView(withAccessibilityIdentifier: "imageView") as? UIImageView
        
        // When
        sut.configure(image: nil)
        
        // Then
        XCTAssertNil(imageView?.image)
    }
    
    func testConfigureWithImageShouldSetImageViewImage() {
        // Given
        let image = UIImage(systemName: "photo")
        let imageView = sut.findView(withAccessibilityIdentifier: "imageView") as? UIImageView
        
        // When
        sut.configure(image: image)
        
        // Then
        XCTAssertNotNil(imageView?.image)
    }
}
