//
//  TokenFilterScreenModelTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenFilterScreenModelTests: XCTestCase {
    
    func testInitWithDefaultValuesShouldCreateEmptyModel() {
        // Given
        
        // When
        let model = TokenFilterScreenModel()
        
        // Then
        XCTAssertTrue(model.isButtonEnabled)
        XCTAssertEqual(model.nameFilterText, "")
        XCTAssertEqual(model.selectedColors.count, 0)
    }
    
    func testInitWithCustomValuesShouldSetProperties() {
        // Given
        let selectedColors: Set<MagicColor> = [.white, .blue]
        
        // When
        let model = TokenFilterScreenModel(isButtonEnabled: false, nameFilterText: "elf", selectedColors: selectedColors)
        
        // Then
        XCTAssertFalse(model.isButtonEnabled)
        XCTAssertEqual(model.nameFilterText, "elf")
        XCTAssertEqual(model.selectedColors.count, 2)
        XCTAssertTrue(model.selectedColors.contains(.white))
        XCTAssertTrue(model.selectedColors.contains(.blue))
    }
    
    func testInitWithNameFilterTextOnlyShouldSetName() {
        // Given
        
        // When
        let model = TokenFilterScreenModel(nameFilterText: "test")
        
        // Then
        XCTAssertEqual(model.nameFilterText, "test")
        XCTAssertTrue(model.isButtonEnabled)
        XCTAssertEqual(model.selectedColors.count, 0)
    }
    
    func testInitWithSelectedColorsOnlyShouldSetColors() {
        // Given
        let selectedColors: Set<MagicColor> = [.red, .green]
        
        // When
        let model = TokenFilterScreenModel(selectedColors: selectedColors)
        
        // Then
        XCTAssertEqual(model.selectedColors.count, 2)
        XCTAssertTrue(model.selectedColors.contains(.red))
        XCTAssertTrue(model.selectedColors.contains(.green))
        XCTAssertTrue(model.isButtonEnabled)
        XCTAssertEqual(model.nameFilterText, "")
    }
    
    func testInitWithAllPropertiesShouldSetAllValues() {
        // Given
        let selectedColors: Set<MagicColor> = [.black]
        
        // When
        let model = TokenFilterScreenModel(isButtonEnabled: false, nameFilterText: "warrior", selectedColors: selectedColors)
        
        // Then
        XCTAssertFalse(model.isButtonEnabled)
        XCTAssertEqual(model.nameFilterText, "warrior")
        XCTAssertEqual(model.selectedColors.count, 1)
        XCTAssertTrue(model.selectedColors.contains(.black))
    }
}


