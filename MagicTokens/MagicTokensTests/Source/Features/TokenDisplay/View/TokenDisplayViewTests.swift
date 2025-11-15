//
//  TokenDisplayViewTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenDisplayViewTests: XCTestCase {
    var sut: TokenDisplayView!
    
    override func setUp() {
        super.setUp()
        sut = TokenDisplayView()
        sut.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    func testInitShouldSetupSubviews() {
        // Then
        XCTAssertEqual(sut.subviews.count, 2)
        XCTAssertEqual(sut.backgroundColor, .systemBackground)
        
        let imageView = sut.findView(withAccessibilityIdentifier: "tokenImageView") as? UIImageView
        XCTAssertNotNil(imageView)
        XCTAssertEqual(imageView?.contentMode, .scaleAspectFit)
        XCTAssertEqual(imageView?.backgroundColor, .systemBackground)
        XCTAssertEqual(imageView?.alpha, 0)
        
        let loadingView = sut.subviews.first(where: { $0 is LoadingView }) as? LoadingView
        XCTAssertNotNil(loadingView)
        XCTAssertTrue(loadingView?.isHidden ?? false)
    }
    
    func testConfigureWithNilImageAndNotLoadingShouldSetImageViewImageToNil() {
        // Given
        let token = Token.stub()
        let model = TokenDisplayScreenModel(token: token, image: nil, isLoading: false)
        let imageView = sut.findView(withAccessibilityIdentifier: "tokenImageView") as? UIImageView
        
        // When
        sut.configure(model: model)
        
        // Then
        XCTAssertNil(imageView?.image)
        XCTAssertEqual(imageView?.accessibilityLabel, "Imagem carregada")
    }
    
    func testConfigureWithImageAndNotLoadingShouldSetImageViewImage() {
        // Given
        let token = Token.stub()
        let image = UIImage(systemName: "photo")
        let model = TokenDisplayScreenModel(token: token, image: image, isLoading: false)
        let imageView = sut.findView(withAccessibilityIdentifier: "tokenImageView") as? UIImageView
        
        // When
        sut.configure(model: model)
        
        // Then
        XCTAssertNotNil(imageView?.image)
        XCTAssertEqual(imageView?.accessibilityLabel, "Imagem carregada")
    }
    
    func testConfigureWithLoadingTrueShouldShowLoadingView() {
        // Given
        let token = Token.stub()
        let model = TokenDisplayScreenModel(token: token, image: nil, isLoading: true)
        let loadingView = sut.subviews.first(where: { $0 is LoadingView }) as? LoadingView
        
        // When
        sut.configure(model: model)
        
        // Then
        XCTAssertFalse(loadingView?.isHidden ?? true)
    }
    
    func testConfigureWithLoadingFalseShouldHideLoadingView() {
        // Given
        let token = Token.stub()
        let model = TokenDisplayScreenModel(token: token, image: nil, isLoading: false)
        let loadingView = sut.subviews.first(where: { $0 is LoadingView }) as? LoadingView
        
        // When
        sut.configure(model: model)
        
        // Then
        XCTAssertTrue(loadingView?.isHidden ?? false)
    }
    
    func testConfigureWithLoadingTrueShouldSetImageViewAlphaToZero() {
        // Given
        let token = Token.stub()
        let image = UIImage(systemName: "photo")
        let model = TokenDisplayScreenModel(token: token, image: image, isLoading: true)
        let imageView = sut.findView(withAccessibilityIdentifier: "tokenImageView") as? UIImageView
        
        // When
        sut.configure(model: model)
        
        // Then
        XCTAssertEqual(imageView?.alpha, 0)
    }
}
