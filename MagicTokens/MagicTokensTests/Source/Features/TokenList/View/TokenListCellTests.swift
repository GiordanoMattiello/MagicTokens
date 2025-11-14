//
//  TokenListCellTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
import CommonKit
import CommonKitTestSources
@testable import MagicTokens

final class TokenListCellTests: XCTestCase {
    var sut: TokenListCell!
    
    override func setUp() {
        super.setUp()
        sut = TokenListCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    func testInitWithFrameSetsUpCorrectly() {
        // Given
        let imageView = sut.findView(withAccessibilityIdentifier: "imageView") as? UIImageView
        let imageViewContainer = sut.findView(withAccessibilityIdentifier: "imageViewContainer")
        
        // Then
        XCTAssertNotNil(imageView)
        XCTAssertNotNil(imageViewContainer)
        XCTAssertEqual(imageView?.contentMode, .scaleToFill)
    }
    
    func testPrepareForReuseResetsImage() {
        // Given
        let testImage = UIImage(systemName: "square.and.arrow.up.circle.fill")
        let placeHolderImage = UIImage(systemName: "photo")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        sut.configure(with: testImage)
        
        // When
        sut.prepareForReuse()
        
        // Then
        let imageView = sut.findView(withAccessibilityIdentifier: "imageView") as? UIImageView
        XCTAssertEqual(imageView?.image,placeHolderImage)
        
    }
    
    func testConfigureWithImageSetsImageView() {
        // Given
        let testImage = UIImage(systemName: "square.and.arrow.up.circle.fill")
        let resultImage = testImage?.withRoundedCorners(radius: 100 * Constants.cardBorderProportion)
        
        // When
        sut.configure(with: testImage)
        
        // Then
        let imageView = sut.findView(withAccessibilityIdentifier: "imageView") as? UIImageView
        XCTAssertEqual(imageView?.image?.pixelData(),resultImage?.pixelData())
    }
    
    func testConfigureWithNilImageSetsImageView() {
        // When
        sut.configure(with: nil)
        
        // Then
        let imageView = sut.findView(withAccessibilityIdentifier: "imageView") as? UIImageView
        XCTAssertNil(imageView?.image)
    }
}
