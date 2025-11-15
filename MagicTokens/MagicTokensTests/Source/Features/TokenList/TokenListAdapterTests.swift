//
//  TokenListAdapterTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenListAdapterTests: XCTestCase {
    var sut: TokenListAdapter!
    
    // Mocks
    override func setUp() {
        sut = TokenListAdapter()
    }

    func testAdaptToken() {
        // Given
        let expectedToken = Token(smallImageURL: "https://example.com/small.png",
                                  largeImageURL: "https://example.com/large.png",
                                  name: "Token Name",
                                  type:  "Token Creature — Spirit",
                                  power: "1",
                                  toughness: "1")

        // When
        let token = sut.tokenAdapt(.stub())
        
        // Then
        XCTAssertEqual(token,expectedToken)
    }
    
    func testAdaptTokenWitoutImageUris() {
        // When
        let token = sut.tokenAdapt(.stub(imageUris: nil))
        
        // Then
        XCTAssertNil(token)
    }
    
    func testAdaptTokenWithPowerAndToughnessNil() {
        // Given
        let scryToken = TokenScryFall.stub(power: nil, toughness: nil)
        let expectedToken = Token(smallImageURL: "https://example.com/small.png",
                                  largeImageURL: "https://example.com/large.png",
                                  name: "Token Name",
                                  type: "Token Creature — Spirit",
                                  power: nil,
                                  toughness: nil)
        
        // When
        let token = sut.tokenAdapt(scryToken)
        
        // Then
        XCTAssertEqual(token, expectedToken)
    }
    
    func testAdaptTokenWithPowerNilAndToughnessValue() {
        // Given
        let scryToken = TokenScryFall.stub(power: nil, toughness: "2")
        let expectedToken = Token(smallImageURL: "https://example.com/small.png",
                                  largeImageURL: "https://example.com/large.png",
                                  name: "Token Name",
                                  type: "Token Creature — Spirit",
                                  power: nil,
                                  toughness: "2")
        
        // When
        let token = sut.tokenAdapt(scryToken)
        
        // Then
        XCTAssertEqual(token, expectedToken)
    }
    
    func testAdaptTokenWithPowerValueAndToughnessNil() {
        // Given
        let scryToken = TokenScryFall.stub(power: "3", toughness: nil)
        let expectedToken = Token(smallImageURL: "https://example.com/small.png",
                                  largeImageURL: "https://example.com/large.png",
                                  name: "Token Name",
                                  type: "Token Creature — Spirit",
                                  power: "3",
                                  toughness: nil)
        
        // When
        let token = sut.tokenAdapt(scryToken)
        
        // Then
        XCTAssertEqual(token, expectedToken)
    }
    
    func testAdaptTokenWithDifferentPowerAndToughnessValues() {
        // Given
        let scryToken = TokenScryFall.stub(power: "5", toughness: "7")
        let expectedToken = Token(smallImageURL: "https://example.com/small.png",
                                  largeImageURL: "https://example.com/large.png",
                                  name: "Token Name",
                                  type: "Token Creature — Spirit",
                                  power: "5",
                                  toughness: "7")
        
        // When
        let token = sut.tokenAdapt(scryToken)
        
        // Then
        XCTAssertEqual(token, expectedToken)
    }
    
    func testAdaptTokenWithAllFieldsMappedCorrectly() {
        // Given
        let imageUris = ImageUris.stub(small: "https://custom.com/small.jpg",
                                       large: "https://custom.com/large.jpg")
        let scryToken = TokenScryFall.stub(name: "Custom Token",
                                          imageUris: imageUris,
                                          typeLine: "Token Creature — Angel",
                                          power: "4",
                                          toughness: "4")
        
        // When
        let token = sut.tokenAdapt(scryToken)
        
        // Then
        XCTAssertNotNil(token)
        XCTAssertEqual(token?.smallImageURL, "https://custom.com/small.jpg")
        XCTAssertEqual(token?.largeImageURL, "https://custom.com/large.jpg")
        XCTAssertEqual(token?.name, "Custom Token")
        XCTAssertEqual(token?.type, "Token Creature — Angel")
        XCTAssertEqual(token?.power, "4")
        XCTAssertEqual(token?.toughness, "4")
    }
}
