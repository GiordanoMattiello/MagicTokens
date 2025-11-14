//
//  UIColorTests+Extensions.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import MagicTokens

final class UIColorInvertedTests: XCTestCase {
    
    func testInvertedWithRGBColorShouldReturnInvertedColor() {
        // Given
        let redColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let blueColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.5)
        let greenColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.8)
        
        // When
        let invertedRed = redColor.inverted()
        let invertedBlue = blueColor.inverted()
        let invertedGreen = greenColor.inverted()
        
        // Then
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        
        // Test red inversion
        XCTAssertEqual(invertedRed?.getRed(&red, green: &green, blue: &blue, alpha: &alpha), true)
        XCTAssertEqual(red, 0.0, accuracy: 0.001)
        XCTAssertEqual(green, 1.0, accuracy: 0.001)
        XCTAssertEqual(blue, 1.0, accuracy: 0.001)
        XCTAssertEqual(alpha, 1.0, accuracy: 0.001)
        
        // Test blue inversion
        XCTAssertEqual(invertedBlue?.getRed(&red, green: &green, blue: &blue, alpha: &alpha), true)
        XCTAssertEqual(red, 1.0, accuracy: 0.001)
        XCTAssertEqual(green, 1.0, accuracy: 0.001)
        XCTAssertEqual(blue, 0.0, accuracy: 0.001)
        XCTAssertEqual(alpha, 0.5, accuracy: 0.001)
        
        // Test green inversion
        XCTAssertEqual(invertedGreen?.getRed(&red, green: &green, blue: &blue, alpha: &alpha), true)
        XCTAssertEqual(red, 1.0, accuracy: 0.001)
        XCTAssertEqual(green, 0.0, accuracy: 0.001)
        XCTAssertEqual(blue, 1.0, accuracy: 0.001)
        XCTAssertEqual(alpha, 0.8, accuracy: 0.001)
    }
    
    func testInvertedWithMidRangeColorsShouldReturnCorrectInversion() {
        // Given
        let midColor = UIColor(red: 0.3, green: 0.6, blue: 0.9, alpha: 0.7)
        
        // When
        let invertedMidColor = midColor.inverted()
        
        // Then
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        XCTAssertEqual(invertedMidColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha), true)
        XCTAssertEqual(red, 0.7, accuracy: 0.001)  // 1.0 - 0.3
        XCTAssertEqual(green, 0.4, accuracy: 0.001) // 1.0 - 0.6
        XCTAssertEqual(blue, 0.1, accuracy: 0.001)  // 1.0 - 0.9
        XCTAssertEqual(alpha, 0.7, accuracy: 0.001)
    }
    
    func testInvertedTwiceShouldReturnOriginalColor() {
        // Given
        let originalColor = UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 0.6)
        
        // When
        let invertedOnce = originalColor.inverted()
        let invertedTwice = invertedOnce?.inverted()
        
        // Then
        var originalRed: CGFloat = 0.0, originalGreen: CGFloat = 0.0, originalBlue: CGFloat = 0.0, originalAlpha: CGFloat = 0.0
        var twiceRed: CGFloat = 0.0, twiceGreen: CGFloat = 0.0, twiceBlue: CGFloat = 0.0, twiceAlpha: CGFloat = 0.0
        
        XCTAssertTrue(originalColor.getRed(&originalRed, green: &originalGreen, blue: &originalBlue, alpha: &originalAlpha))
        XCTAssertEqual(invertedTwice?.getRed(&twiceRed, green: &twiceGreen, blue: &twiceBlue, alpha: &twiceAlpha), true)
        
        XCTAssertEqual(originalRed, twiceRed, accuracy: 0.001)
        XCTAssertEqual(originalGreen, twiceGreen, accuracy: 0.001)
        XCTAssertEqual(originalBlue, twiceBlue, accuracy: 0.001)
        XCTAssertEqual(originalAlpha, twiceAlpha, accuracy: 0.001)
    }
    
    func testInvertedWithUnsupportedColorSpaceShouldReturnSameColor() {
        // Given
        let patternColor = UIColor(patternImage: UIImage())
        
        // When
        let invertedPattern = patternColor.inverted()
        
        // Then
        XCTAssertNil(invertedPattern)
    }
}
