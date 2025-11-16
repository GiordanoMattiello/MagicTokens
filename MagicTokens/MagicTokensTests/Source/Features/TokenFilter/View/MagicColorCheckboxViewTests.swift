//
//  MagicColorCheckboxViewTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import XCTest
@testable import MagicTokens

final class MagicColorCheckboxViewTests: XCTestCase {
    
    func testInitWithWhiteColorShouldSetupView() {
        // Given
        let color = MagicColor.white
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        XCTAssertFalse(sut.isSelected)
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        XCTAssertNotNil(button)
        XCTAssertEqual(button?.accessibilityLabel, "Filtrar por cor Branco")
    }
    
    func testInitWithBlueColorShouldSetupView() {
        // Given
        let color = MagicColor.blue
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        XCTAssertFalse(sut.isSelected)
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_U") as? UIButton
        XCTAssertNotNil(button)
        XCTAssertEqual(button?.accessibilityLabel, "Filtrar por cor Azul")
    }
    
    func testInitWithBlackColorShouldSetupView() {
        // Given
        let color = MagicColor.black
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        XCTAssertFalse(sut.isSelected)
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_B") as? UIButton
        XCTAssertNotNil(button)
        XCTAssertEqual(button?.accessibilityLabel, "Filtrar por cor Preto")
    }
    
    func testInitWithRedColorShouldSetupView() {
        // Given
        let color = MagicColor.red
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        XCTAssertFalse(sut.isSelected)
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_R") as? UIButton
        XCTAssertNotNil(button)
        XCTAssertEqual(button?.accessibilityLabel, "Filtrar por cor Vermelho")
    }
    
    func testInitWithGreenColorShouldSetupView() {
        // Given
        let color = MagicColor.green
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        XCTAssertFalse(sut.isSelected)
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_G") as? UIButton
        XCTAssertNotNil(button)
        XCTAssertEqual(button?.accessibilityLabel, "Filtrar por cor Verde")
    }
    
    func testInitWithColorlessColorShouldSetupView() {
        // Given
        let color = MagicColor.colorless
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        XCTAssertFalse(sut.isSelected)
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_C") as? UIButton
        XCTAssertNotNil(button)
        XCTAssertEqual(button?.accessibilityLabel, "Filtrar por cor Incolor")
    }
    
    func testConfigureWithIsSelectedTrueShouldSetSelectedState() {
        // Given
        let sut = MagicColorCheckboxView(color: .white)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // When
        sut.configure(isSelected: true)
        
        // Then
        XCTAssertTrue(sut.isSelected)
    }
    
    func testConfigureWithIsSelectedFalseShouldSetUnselectedState() {
        // Given
        let sut = MagicColorCheckboxView(color: .white)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        sut.configure(isSelected: true)
        
        // When
        sut.configure(isSelected: false)
        
        // Then
        XCTAssertFalse(sut.isSelected)
    }
    
    func testSetToggleActionShouldCallActionWhenButtonTapped() {
        // Given
        let sut = MagicColorCheckboxView(color: .white)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        let expectation = expectation(description: "Toggle action called")
        var actionCalled = false
        
        // When
        sut.setToggleAction {
            actionCalled = true
            expectation.fulfill()
        }
        
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        button?.sendActions(for: .touchUpInside)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertTrue(actionCalled)
    }
    
    func testInitShouldCreateAllSubviews() {
        // Given
        let color = MagicColor.white
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        XCTAssertNotNil(button)
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertTrue(sut.subviews.contains(button!))
    }
    
    func testInitShouldSetCorrectTitleLabel() {
        // Given
        let color = MagicColor.white
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        let titleLabel = button?.subviews.first(where: { $0 is UILabel }) as? UILabel
        XCTAssertNotNil(titleLabel)
        XCTAssertEqual(titleLabel?.text, "Branco (W)")
    }
    
    func testInitShouldSetCorrectColorDotForWhite() {
        // Given
        let color = MagicColor.white
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        let colorDot = button?.subviews.first(where: { $0.backgroundColor != nil && $0.layer.cornerRadius == 10 }) as? UIView
        XCTAssertNotNil(colorDot)
        XCTAssertEqual(colorDot?.backgroundColor, color.uiColor)
    }
    
    func testInitShouldSetCorrectColorDotForBlue() {
        // Given
        let color = MagicColor.blue
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_U") as? UIButton
        let colorDot = button?.subviews.first(where: { $0.backgroundColor != nil && $0.layer.cornerRadius == 10 }) as? UIView
        XCTAssertNotNil(colorDot)
        XCTAssertEqual(colorDot?.backgroundColor, color.uiColor)
    }
    
    func testConfigureShouldUpdateCheckboxImageWhenSelected() {
        // Given
        let sut = MagicColorCheckboxView(color: .white)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        let checkboxImageView = button?.subviews.first(where: { $0 is UIImageView }) as? UIImageView
        let initialImage = checkboxImageView?.image
        
        // When
        sut.configure(isSelected: true)
        
        // Then
        let selectedImage = checkboxImageView?.image
        XCTAssertNotEqual(initialImage, selectedImage)
        XCTAssertTrue(selectedImage?.isEqual(UIImage(systemName: "checkmark.square.fill")) ?? false)
    }
    
    func testConfigureShouldUpdateCheckboxImageWhenUnselected() {
        // Given
        let sut = MagicColorCheckboxView(color: .white)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        sut.configure(isSelected: true)
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        let checkboxImageView = button?.subviews.first(where: { $0 is UIImageView }) as? UIImageView
        let selectedImage = checkboxImageView?.image
        
        // When
        sut.configure(isSelected: false)
        
        // Then
        let unselectedImage = checkboxImageView?.image
        XCTAssertNotEqual(selectedImage, unselectedImage)
        XCTAssertTrue(unselectedImage?.isEqual(UIImage(systemName: "square")) ?? false)
    }
    
    func testInitShouldSetButtonHeightTo44() {
        // Given
        let color = MagicColor.white
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        XCTAssertNotNil(button)
        let heightConstraint = button?.constraints.first(where: { $0.firstAttribute == .height && $0.constant == 44 })
        XCTAssertNotNil(heightConstraint)
    }
    
    func testInitShouldSetButtonAsAccessibilityElement() {
        // Given
        let color = MagicColor.white
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        XCTAssertTrue(button?.isAccessibilityElement ?? false)
    }
    
    func testSetToggleActionShouldAllowMultipleCalls() {
        // Given
        let sut = MagicColorCheckboxView(color: .white)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        var callCount = 0
        let expectation = expectation(description: "Toggle action called twice")
        expectation.expectedFulfillmentCount = 2
        
        // When
        sut.setToggleAction {
            callCount += 1
            expectation.fulfill()
        }
        
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        button?.sendActions(for: .touchUpInside)
        button?.sendActions(for: .touchUpInside)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(callCount, 2)
    }
    
    func testInitShouldSetCheckboxImageViewProperties() {
        // Given
        let color = MagicColor.white
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        let checkboxImageView = button?.subviews.first(where: { $0 is UIImageView }) as? UIImageView
        XCTAssertNotNil(checkboxImageView)
        XCTAssertEqual(checkboxImageView?.tintColor, .systemBlue)
        XCTAssertEqual(checkboxImageView?.contentMode, .scaleAspectFit)
        XCTAssertFalse(checkboxImageView?.isUserInteractionEnabled ?? true)
        XCTAssertTrue(checkboxImageView?.image?.isEqual(UIImage(systemName: "square")) ?? false)
    }
    
    func testInitShouldSetColorDotProperties() {
        // Given
        let color = MagicColor.white
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        let colorDot = button?.subviews.first(where: { $0.backgroundColor != nil && $0.layer.cornerRadius == 10 }) as? UIView
        XCTAssertNotNil(colorDot)
        XCTAssertEqual(colorDot?.layer.cornerRadius, 10)
        XCTAssertEqual(colorDot?.layer.borderWidth, 1)
        XCTAssertFalse(colorDot?.isUserInteractionEnabled ?? true)
    }
    
    func testInitShouldSetTitleLabelProperties() {
        // Given
        let color = MagicColor.white
        
        // When
        let sut = MagicColorCheckboxView(color: color)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // Then
        let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        let titleLabel = button?.subviews.first(where: { $0 is UILabel }) as? UILabel
        XCTAssertNotNil(titleLabel)
        XCTAssertEqual(titleLabel?.font, .systemFont(ofSize: 16))
        XCTAssertEqual(titleLabel?.textColor, .label)
        XCTAssertFalse(titleLabel?.isUserInteractionEnabled ?? true)
    }
    
    func testConfigureShouldUpdateIsSelectedProperty() {
        // Given
        let sut = MagicColorCheckboxView(color: .white)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        
        // When
        sut.configure(isSelected: true)
        
        // Then
        XCTAssertTrue(sut.isSelected)
        
        // When
        sut.configure(isSelected: false)
        
        // Then
        XCTAssertFalse(sut.isSelected)
    }
    
    func testInitShouldSetCorrectTitleForAllColors() {
        // Given & When & Then
        for color in MagicColor.allCases {
            let sut = MagicColorCheckboxView(color: color)
            sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
            let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_\(color.rawValue)") as? UIButton
            let titleLabel = button?.subviews.first(where: { $0 is UILabel }) as? UILabel
            XCTAssertEqual(titleLabel?.text, "\(color.displayName) (\(color.rawValue))", "Title should match for color \(color.rawValue)")
        }
    }
    
    func testInitShouldSetCorrectColorDotForAllColors() {
        // Given & When & Then
        for color in MagicColor.allCases {
            let sut = MagicColorCheckboxView(color: color)
            sut.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
            let button = sut.findView(withAccessibilityIdentifier: "colorCheckbox_\(color.rawValue)") as? UIButton
            let colorDot = button?.subviews.first(where: { $0.backgroundColor != nil && $0.layer.cornerRadius == 10 }) as? UIView
            XCTAssertEqual(colorDot?.backgroundColor, color.uiColor, "Color dot should match for color \(color.rawValue)")
        }
    }
}

