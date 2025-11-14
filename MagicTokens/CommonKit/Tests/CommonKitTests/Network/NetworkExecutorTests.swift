//
//  NetworkExecutorTests.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 14/11/25.
//

import XCTest
@testable import CommonKit

final class NetworkExecutorTests: XCTestCase {
    var sut: NetworkExecutor!
    var urlSessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        urlSessionMock = URLSessionMock()
        sut = NetworkExecutor(session: urlSessionMock)
    }
    
    func testExecuteWithValidRequestShouldReturnData() async {
        // Given
        let expectedData = "test data".data(using: .utf8)
        let request = NetworkRequestMock()
        let url = URL(string: "https://example.com")!
        guard let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        ) else {
            fatalError()
        }
        urlSessionMock.dataForReturnValue = (expectedData ?? Data(), response)
        
        // When
        let result = try? await sut.execute(request: request)
            
        // Then
        XCTAssertEqual(result, expectedData)
        XCTAssertEqual(urlSessionMock.dataForCallCount, 1)

    }
    
    func testExecuteWithInvalidURLShouldThrowInvalidURLError() async {
        // Given
        let request = NetworkRequestMock(url: "", method: .get)
        
        // When
        do {
            _ = try await sut.execute(request: request)
            XCTFail("Should throw error")
        } catch {
            XCTAssertEqual(NetworkError.invalidURL, error as? NetworkError)
        }
    }
    
    func testExecuteWithHTTPErrorShouldThrowStatusError() async {
        // Given
        let request = NetworkRequestMock(url: "https://example.com", method: .get)
        let url = URL(string: "https://example.com")!
        guard let response = HTTPURLResponse(
            url: url,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        ) else {
            fatalError()
        }
        urlSessionMock.dataForReturnValue = (Data(), response)
        
        // When
        do {
            _ = try await sut.execute(request: request)
            XCTFail("Should throw error")
        } catch {
            // Then
            XCTAssertEqual(NetworkError.statusError(404), error as? NetworkError)
        }
    }
    
    func testExecuteWithNetworkErrorShouldThrowUnknownError() async {
        // Given
        let request = NetworkRequestMock(url: "https://example.com", method: .get)
        let networkError = NSError(domain: "NSURLErrorDomain", code: -1009, userInfo: nil)
        urlSessionMock.dataForError = networkError
        
        // When
        do {
            _ = try await sut.execute(request: request)
            XCTFail("Should throw error")
        } catch {
            // Then
            XCTAssertEqual(NetworkError.unknown(networkError), error as? NetworkError)
        }
    }
}
