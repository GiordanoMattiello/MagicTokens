//
//  TokenFilterViewControllerTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import XCTest
import Combine
@testable import MagicTokens

final class TokenFilterViewControllerTests: XCTestCase {
    var sut: TokenFilterViewController!
    var viewContentMock: TokenFilterViewMock!
    var viewModelMock: TokenFilterViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewContentMock = TokenFilterViewMock()
        viewModelMock = TokenFilterViewModelMock()
        sut = TokenFilterViewController(contentView: viewContentMock, viewModel: viewModelMock)
    }
    
    func testViewDidLoadShouldSetNavigationTitle() {
        // Given
        let navigationController = UINavigationController(rootViewController: sut)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.title, "Filtros")
        XCTAssertEqual(navigationController.navigationBar.topItem?.backButtonTitle, "")
    }
    
    func testLoadViewShouldSetContentViewAsView() {
        // Given
        
        // When
        sut.loadView()
        
        // Then
        XCTAssertTrue(sut.view === viewContentMock)
    }
    
    func testViewDidLoadShouldSetupBindings() {
        // Given
        let expectation = expectation(description: "Configure called")
        viewContentMock.onCompleteConfigure = {
            expectation.fulfill()
        }
        
        // When
        sut.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(viewContentMock.configureCallCount, 1)
    }
    
    func testViewDidLoadShouldSetupActions() {
        // Given
        let realView = TokenFilterView()
        let realSut = TokenFilterViewController(contentView: realView, viewModel: viewModelMock)
        realSut.loadView()
        realSut.viewDidLoad()
        
        // When
        let nameTextField = realView.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        nameTextField?.text = "test"
        nameTextField?.sendActions(for: .editingChanged)
        
        // Then
        XCTAssertEqual(viewModelMock.updateNameFilterCallCount, 1)
    }
    
    func testScreenModelPublisherWhenScreenModelChangesShouldCallConfigure() {
        // Given
        sut.viewDidLoad()
        let expectation = expectation(description: "Configure called on model change")
        viewContentMock.onCompleteConfigure = {
            expectation.fulfill()
        }
        
        // When
        viewModelMock.screenModel = TokenFilterScreenModel(nameFilterText: "elf")
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(viewContentMock.configureCallCount, 2)
        XCTAssertEqual(viewContentMock.receivedScreenModel?.nameFilterText, "elf")
    }
    
    func testApplyFilterActionShouldCallViewModelApplyFilter() {
        // Given
        let realView = TokenFilterView()
        let realSut = TokenFilterViewController(contentView: realView, viewModel: viewModelMock)
        realSut.loadView()
        realSut.viewDidLoad()
        
        // When
        let applyFilterButton = realView.findView(withAccessibilityIdentifier: "applyFilterButton") as? UIButton
        applyFilterButton?.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertEqual(viewModelMock.applyFilterCallCount, 1)
    }
    
    func testNameFilterTextChangeActionShouldCallViewModelUpdateNameFilter() {
        // Given
        let realView = TokenFilterView()
        let realSut = TokenFilterViewController(contentView: realView, viewModel: viewModelMock)
        realSut.loadView()
        realSut.viewDidLoad()
        
        // When
        let nameTextField = realView.findView(withAccessibilityIdentifier: "nameTextField") as? UITextField
        nameTextField?.text = "elf"
        nameTextField?.sendActions(for: .editingChanged)
        
        // Then
        XCTAssertEqual(viewModelMock.updateNameFilterCallCount, 1)
        XCTAssertEqual(viewModelMock.updateNameFilterReceivedText, "elf")
    }
    
    func testColorToggleActionShouldCallViewModelToggleColor() {
        // Given
        let realView = TokenFilterView()
        let realSut = TokenFilterViewController(contentView: realView, viewModel: viewModelMock)
        realSut.loadView()
        realSut.viewDidLoad()
        
        // When
        let whiteCheckbox = realView.findView(withAccessibilityIdentifier: "colorCheckbox_W") as? UIButton
        whiteCheckbox?.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertEqual(viewModelMock.toggleColorCallCount, 1)
        XCTAssertEqual(viewModelMock.toggleColorReceivedColor, .white)
    }
}

