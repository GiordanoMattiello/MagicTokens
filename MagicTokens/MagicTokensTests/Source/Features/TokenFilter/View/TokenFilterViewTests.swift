//
//  TokenFilterViewTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import XCTest
@testable import MagicTokens

final class TokenFilterViewTests: XCTestCase {
    var sut: TokenFilterView!
    
    override func setUp() {
        super.setUp()
        sut = TokenFilterView()
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
    }
    
    func testInitShouldSetupSubviews() {
        // Given
        
        // When
        
        // Then
        XCTAssertEqual(sut.backgroundColor, .systemBackground)
        
        let nameTextField = sut.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        XCTAssertNotNil(nameTextField)
        XCTAssertEqual(nameTextField?.placeholder, "Nome do token")
        
        let applyFilterButton = sut.findView(withAccessibilityIdentifier: "applyFilterButton") as? UIButton
        XCTAssertNotNil(applyFilterButton)
        XCTAssertEqual(applyFilterButton?.title(for: .normal), "Aplicar Filtro")
    }
    
    func testConfigureWithEnabledButtonShouldEnableButton() {
        // Given
        let model = TokenFilterScreenModel(isButtonEnabled: true)
        
        // When
        sut.configure(model: model)
        
        // Then
        let applyFilterButton = sut.findView(withAccessibilityIdentifier: "applyFilterButton") as? UIButton
        XCTAssertTrue(applyFilterButton?.isEnabled ?? false)
        XCTAssertEqual(applyFilterButton?.alpha, 1.0)
    }
    
    func testConfigureWithDisabledButtonShouldDisableButton() {
        // Given
        let model = TokenFilterScreenModel(isButtonEnabled: false)
        
        // When
        sut.configure(model: model)
        
        // Then
        let applyFilterButton = sut.findView(withAccessibilityIdentifier: "applyFilterButton") as? UIButton
        XCTAssertFalse(applyFilterButton?.isEnabled ?? true)
        XCTAssertEqual(applyFilterButton?.alpha, 0.5)
    }
    
    func testConfigureShouldUpdateNameTextField() {
        // Given
        let model = TokenFilterScreenModel(nameFilterText: "elf")
        
        // When
        sut.configure(model: model)
        
        // Then
        let nameTextField = sut.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        XCTAssertEqual(nameTextField?.text, "elf")
    }
    
    func testConfigureWithSelectedColorsShouldUpdateCheckboxes() {
        // Given
        let model = TokenFilterScreenModel(selectedColors: [.white, .blue])
        
        // When
        sut.configure(model: model)
        
        // Then
        let whiteCheckbox = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        let blueCheckbox = sut.findView(withAccessibilityIdentifier: "colorCheckbox_U") as? UIButton
        let redCheckbox = sut.findView(withAccessibilityIdentifier: "colorCheckbox_R") as? UIButton
        
        XCTAssertNotNil(whiteCheckbox)
        XCTAssertNotNil(blueCheckbox)
        XCTAssertNotNil(redCheckbox)
    }
    
    func testDidTapApplyFilterShouldCallDelegate() {
        // Given
        let delegateMock = TokenFilterViewDelegateMock()
        sut.delegate = delegateMock
        let expectation = expectation(description: "Delegate didTapApplyFilter called")
        delegateMock.onDidTapApplyFilter = {
            expectation.fulfill()
        }
        
        // When
        let applyFilterButton = sut.findView(withAccessibilityIdentifier: "applyFilterButton") as? UIButton
        applyFilterButton?.sendActions(for: .touchUpInside)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(delegateMock.didTapApplyFilterCallCount, 1)
    }
    
    func testDidChangeNameFilterShouldCallDelegate() {
        // Given
        let delegateMock = TokenFilterViewDelegateMock()
        sut.delegate = delegateMock
        let expectation = expectation(description: "Delegate didChangeNameFilter called")
        var receivedText: String?
        delegateMock.onDidChangeNameFilter = { text in
            receivedText = text
            expectation.fulfill()
        }
        
        // When
        let nameTextField = sut.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        nameTextField?.text = "elf"
        nameTextField?.sendActions(for: .editingChanged)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(delegateMock.didChangeNameFilterCallCount, 1)
        XCTAssertEqual(receivedText, "elf")
    }
    
    func testNameTextFieldEditingChangedShouldCallDelegateMultipleTimes() {
        // Given
        let delegateMock = TokenFilterViewDelegateMock()
        sut.delegate = delegateMock
        let expectation = expectation(description: "Delegate didChangeNameFilter called multiple times")
        expectation.expectedFulfillmentCount = 3
        var receivedTexts: [String] = []
        delegateMock.onDidChangeNameFilter = { text in
            receivedTexts.append(text)
            expectation.fulfill()
        }
        
        // When
        let nameTextField = sut.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        nameTextField?.text = "e"
        nameTextField?.sendActions(for: .editingChanged)
        nameTextField?.text = "el"
        nameTextField?.sendActions(for: .editingChanged)
        nameTextField?.text = "elf"
        nameTextField?.sendActions(for: .editingChanged)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(delegateMock.didChangeNameFilterCallCount, 3)
        XCTAssertEqual(receivedTexts, ["e", "el", "elf"])
    }
    
    func testNameTextFieldEditingChangedWithEmptyTextShouldCallDelegate() {
        // Given
        let delegateMock = TokenFilterViewDelegateMock()
        sut.delegate = delegateMock
        let expectation = expectation(description: "Delegate didChangeNameFilter called with empty text")
        var receivedText: String?
        delegateMock.onDidChangeNameFilter = { text in
            receivedText = text
            expectation.fulfill()
        }
        
        // When
        let nameTextField = sut.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        nameTextField?.text = ""
        nameTextField?.sendActions(for: .editingChanged)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(delegateMock.didChangeNameFilterCallCount, 1)
        XCTAssertEqual(receivedText, "")
    }
    
    func testNameTextFieldEditingChangedWithSpecialCharactersShouldCallDelegate() {
        // Given
        let delegateMock = TokenFilterViewDelegateMock()
        sut.delegate = delegateMock
        let expectation = expectation(description: "Delegate didChangeNameFilter called with special characters")
        var receivedText: String?
        delegateMock.onDidChangeNameFilter = { text in
            receivedText = text
            expectation.fulfill()
        }
        
        // When
        let nameTextField = sut.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        nameTextField?.text = "elf warrior 1/1"
        nameTextField?.sendActions(for: .editingChanged)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(delegateMock.didChangeNameFilterCallCount, 1)
        XCTAssertEqual(receivedText, "elf warrior 1/1")
    }
    
    func testDidToggleColorShouldCallDelegate() {
        // Given
        let delegateMock = TokenFilterViewDelegateMock()
        sut.delegate = delegateMock
        let expectation = expectation(description: "Delegate didToggleColor called")
        var receivedColor: MagicColor?
        var receivedIsSelected: Bool?
        delegateMock.onDidToggleColor = { color, isSelected in
            receivedColor = color
            receivedIsSelected = isSelected
            expectation.fulfill()
        }
        
        // When
        let whiteCheckbox = sut.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        whiteCheckbox?.sendActions(for: .touchUpInside)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(delegateMock.didToggleColorCallCount, 1)
        XCTAssertEqual(receivedColor, .white)
        XCTAssertNotNil(receivedIsSelected)
    }
    
    func testInitShouldCreateAllColorCheckboxes() {
        // Given
        
        // When
        
        // Then
        for color in MagicColor.allCases {
            let checkbox = sut.findView(withAccessibilityIdentifier: "colorCheckbox_\(color.rawValue)") as? UIButton
            XCTAssertNotNil(checkbox, "Checkbox for color \(color.rawValue) should exist")
        }
    }
    
    func testTextFieldShouldReturnShouldDismissKeyboard() {
        // Given
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        window.addSubview(sut)
        window.makeKeyAndVisible()
        
        let nameTextField = sut.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        _ = nameTextField?.becomeFirstResponder()
        
        // When
        let shouldReturn = sut.textFieldShouldReturn(nameTextField!)
        
        // Then
        XCTAssertTrue(shouldReturn)
        XCTAssertFalse(nameTextField?.isFirstResponder ?? true)
    }
    
    func testTextFieldReturnKeyTypeShouldBeDone() {
        // Given
        
        // When
        let nameTextField = sut.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        
        // Then
        XCTAssertEqual(nameTextField?.returnKeyType, .done)
    }
}

