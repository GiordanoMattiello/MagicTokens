//
//  MagicColorTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import XCTest
@testable import MagicTokens

final class MagicColorTests: XCTestCase {
    
    func testAllCasesShouldContainAllColors() {
        // When
        let allCases = MagicColor.allCases
        
        // Then
        XCTAssertEqual(allCases.count, 6)
        XCTAssertTrue(allCases.contains(.white))
        XCTAssertTrue(allCases.contains(.blue))
        XCTAssertTrue(allCases.contains(.black))
        XCTAssertTrue(allCases.contains(.red))
        XCTAssertTrue(allCases.contains(.green))
        XCTAssertTrue(allCases.contains(.colorless))
    }
    
    func testDisplayNameForWhiteShouldReturnBranco() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.white.displayName, "Branco")
    }
    
    func testDisplayNameForBlueShouldReturnAzul() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.blue.displayName, "Azul")
    }
    
    func testDisplayNameForBlackShouldReturnPreto() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.black.displayName, "Preto")
    }
    
    func testDisplayNameForRedShouldReturnVermelho() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.red.displayName, "Vermelho")
    }
    
    func testDisplayNameForGreenShouldReturnVerde() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.green.displayName, "Verde")
    }
    
    func testDisplayNameForColorlessShouldReturnIncolor() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.colorless.displayName, "Incolor")
    }
    
    func testRawValueForWhiteShouldReturnW() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.white.rawValue, "W")
    }
    
    func testRawValueForBlueShouldReturnU() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.blue.rawValue, "U")
    }
    
    func testRawValueForBlackShouldReturnB() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.black.rawValue, "B")
    }
    
    func testRawValueForRedShouldReturnR() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.red.rawValue, "R")
    }
    
    func testRawValueForGreenShouldReturnG() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.green.rawValue, "G")
    }
    
    func testRawValueForColorlessShouldReturnC() {
        // Given & When & Then
        XCTAssertEqual(MagicColor.colorless.rawValue, "C")
    }
    
    func testUIColorForWhiteShouldReturnLightGray() {
        // Given & When
        let color = MagicColor.white.uiColor
        
        // Then
        XCTAssertNotNil(color)
    }
    
    func testUIColorForBlueShouldReturnSystemBlue() {
        // Given & When
        let color = MagicColor.blue.uiColor
        
        // Then
        XCTAssertEqual(color, .systemBlue)
    }
    
    func testUIColorForBlackShouldReturnDarkColor() {
        // Given & When
        let color = MagicColor.black.uiColor
        
        // Then
        XCTAssertNotNil(color)
    }
    
    func testUIColorForRedShouldReturnSystemRed() {
        // Given & When
        let color = MagicColor.red.uiColor
        
        // Then
        XCTAssertEqual(color, .systemRed)
    }
    
    func testUIColorForGreenShouldReturnSystemGreen() {
        // Given & When
        let color = MagicColor.green.uiColor
        
        // Then
        XCTAssertEqual(color, .systemGreen)
    }
    
    func testUIColorForColorlessShouldReturnSystemGray() {
        // Given & When
        let color = MagicColor.colorless.uiColor
        
        // Then
        XCTAssertEqual(color, .systemGray)
    }
}


