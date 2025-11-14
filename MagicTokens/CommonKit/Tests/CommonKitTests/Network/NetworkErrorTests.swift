//
//  NetworkErrorTests.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import CommonKit

final class NetworkErrorTests: XCTestCase {
    
    func testInitWithErrorShouldSetUnknownCase() {
        // Given
        let testError = NSError(domain: "Test", code: 123, userInfo: nil)
        
        // When
        let networkError = NetworkError(testError)
        
        // Then
        if case .unknown(let error) = networkError {
            XCTAssertEqual((error as NSError).code, 123)
            XCTAssertEqual((error as NSError).domain, "Test")
        } else {
            XCTFail("Expected .unknown case")
        }
    }
    
    func testInitWithNilErrorShouldSetGenericCase() {
        // When
        let networkError: NetworkError = NetworkError(nil)
        
        // Then
        XCTAssertEqual(networkError, NetworkError.generic)
    }
    
    func testInitWithHTTPURLResponseInValidRangeShouldReturnNil() {
        // Given
        let url = URL(string: "https://example.com")!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let networkError = NetworkError(response)
        
        // Then
        XCTAssertNil(networkError)
    }
    
    func testInitWithHTTPURLResponseStatusCode400ShouldSetStatusError() {
        // Given
        let url = URL(string: "https://example.com")!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let networkError = NetworkError(response)
        
        // Then
        if case .statusError(let statusCode) = networkError {
            XCTAssertEqual(statusCode, 400)
        } else {
            XCTFail("Expected .statusError case with status code 400")
        }
    }
    
    func testInitWithHTTPURLResponseStatusCode500ShouldSetStatusError() {
        // Given
        let url = URL(string: "https://example.com")!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let networkError = NetworkError(response)
        
        // Then
        if case .statusError(let statusCode) = networkError {
            XCTAssertEqual(statusCode, 500)
        } else {
            XCTFail("Expected .statusError case with status code 500")
        }
    }
    
    func testInitWithNonHTTPURLResponseShouldSetInvalidResponse() {
        // Given
        let url = URL(string: "https://example.com")!
        let response = URLResponse(
            url: url,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        
        // When
        let networkError = NetworkError(response)
        
        // Then
        XCTAssertEqual(networkError, .invalidResponse)
    }
    
    func testInitWithNilResponseShouldSetInvalidResponse() {
        // Given
        let nilResponse: URLResponse? = nil
        
        // When
        let networkError = NetworkError(nilResponse)
        
        // Then
        XCTAssertEqual(networkError, .invalidResponse)
    }

    func testAllErrorCasesAreCoveredAndEquatableSuccess() {
        // Test all enum cases exist
        let cases1: [NetworkError] = [
            .invalidURL,
            .invalidResponse,
            .decodingFailed,
            .statusError(404),
            .unknown(NSError(domain: "test", code: 1)),
            .generic
        ]
        
        let cases2: [NetworkError] = [
            .invalidURL,
            .invalidResponse,
            .decodingFailed,
            .statusError(404),
            .unknown(NSError(domain: "test", code: 1)),
            .generic
        ]
        for i in 0..<cases1.count {
            XCTAssertEqual(cases1[i],cases2[i])
        }
    }
    
    func testAllErrorCasesAreCoveredAndEquatableFail() {
        // Test all enum cases exist
        let cases1: [NetworkError] = [
            .invalidURL,
            .invalidResponse,
            .decodingFailed,
            .statusError(404),
            .unknown(NSError(domain: "test", code: 1)),
            .generic
        ]
        
        let cases2: [NetworkError] = [
            .generic,
            .generic,
            .generic,
            .generic,
            .generic,
            .invalidURL
        ]
        for i in 0..<cases1.count {
            XCTAssertNotEqual(cases1[i],cases2[i])
        }
    }
    
    func testStatusErrorWithDifferentStatusCodes() {
        // Given
        let statusCodes = [300, 404, 418, 503]
        
        for statusCode in statusCodes {
            let url = URL(string: "https://example.com")!
            let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )
            
            // When
            let networkError = NetworkError(response)
            
            // Then
            if case .statusError(let receivedStatusCode) = networkError {
                XCTAssertEqual(receivedStatusCode, statusCode)
            } else {
                XCTFail("Expected .statusError case with status code \(statusCode)")
            }
        }
    }
    
    func testValidStatusCodesShouldReturnNil() {
        // Given
        let validStatusCodes = [200, 201, 204, 299]
        
        for statusCode in validStatusCodes {
            let url = URL(string: "https://example.com")!
            let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )
            
            // When
            let networkError = NetworkError(response)
            
            // Then
            XCTAssertNil(networkError, "Should return nil for status code \(statusCode)")
        }
    }
}
