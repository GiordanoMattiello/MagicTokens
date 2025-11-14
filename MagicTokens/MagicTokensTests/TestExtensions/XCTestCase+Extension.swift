//
//  XCTestCase+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//
import XCTest
@testable import MagicTokens

extension XCTestCase {
    func waitForExpectations() {
        waitForExpectations(timeout: 0.5)
    }
    func fulfillment(of expectations: [XCTestExpectation]) async {
        await fulfillment(of: expectations, timeout: 0.5)
    }
}
