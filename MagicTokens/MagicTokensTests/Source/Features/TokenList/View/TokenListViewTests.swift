//
//  TokenListViewTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenListViewTests: XCTestCase {
    var sut: TokenListView!
    var dataSourceMock: TokenListDataSourceProtocolMock!
    var delegateMock: TokenListViewControllerDelegateMock!
    
    override func setUp() {
        super.setUp()
        dataSourceMock = TokenListDataSourceProtocolMock()
        delegateMock = TokenListViewControllerDelegateMock()
        sut = TokenListView(dataSource: dataSourceMock)
    }
    
    func testInitWithDataSourceShouldSetupDataSource() {
        // When
        let customDataSource = TokenListDataSourceProtocolMock()
        let view = TokenListView(dataSource: customDataSource)
        
        // Then
        XCTAssertNotNil(view)
    }
    
    func testSetDelegateShouldUpdateDataSourceDelegate() {
        // When
        sut.delegate = delegateMock
        
        // Then
        XCTAssertIdentical(dataSourceMock.delegate as? TokenListViewControllerDelegateMock, delegateMock)
    }
    
    func testUpdateTokensShouldCallDataSourceUpdateTokens() {
        // Given
        let tokens = [Token]()
        
        // When
        sut.updateTokens(tokens)
        
        // Then
        XCTAssertEqual(dataSourceMock.updateTokensCallCount, 1)
        XCTAssertEqual(dataSourceMock.updateTokensReceivedTokens, tokens)
    }
}
