//
//  TokenListAdapter.swift
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
                                  type:  "Token Creature — Spirit")

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
}
