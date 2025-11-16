//
//  TokenFilterViewModelTests.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import XCTest
import Combine
@testable import MagicTokens

final class TokenFilterViewModelTests: XCTestCase {
    var sut: TokenFilterViewModel!
    var coordinatorMock: CoordinatorsMock!
    var delegateMock: ApplyFilterDelegateMock!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        coordinatorMock = CoordinatorsMock()
        delegateMock = ApplyFilterDelegateMock()
        cancellables = Set<AnyCancellable>()
        sut = TokenFilterViewModel(coordinator: coordinatorMock, delegate: delegateMock)
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    func testInitialStateShouldHaveEmptyScreenModel() {
        // Given
        
        // When
        
        // Then
        XCTAssertEqual(sut.screenModel.nameFilterText, "")
        XCTAssertEqual(sut.screenModel.selectedColors.count, 0)
        XCTAssertTrue(sut.screenModel.isButtonEnabled)
    }
    
    func testUpdateNameFilterShouldUpdateScreenModel() {
        // Given
        let expectation = expectation(description: "Screen model updated")
        var receivedModel: TokenFilterScreenModel?
        
        sut.screenModelPublisher
            .dropFirst()
            .sink { model in
                receivedModel = model
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.updateNameFilter("elf")
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedModel?.nameFilterText, "elf")
        XCTAssertEqual(sut.screenModel.nameFilterText, "elf")
    }
    
    func testToggleColorWhenSelectingColorShouldAddToSelectedColors() {
        // Given
        let expectation = expectation(description: "Screen model updated")
        var receivedModel: TokenFilterScreenModel?
        
        sut.screenModelPublisher
            .dropFirst()
            .sink { model in
                receivedModel = model
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.toggleColor(.white, isSelected: true)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertTrue(receivedModel?.selectedColors.contains(.white) ?? false)
        XCTAssertEqual(receivedModel?.selectedColors.count, 1)
    }
    
    func testToggleColorWhenDeselectingColorShouldRemoveFromSelectedColors() {
        // Given
        sut.toggleColor(.white, isSelected: true)
        
        let expectation = expectation(description: "Screen model updated")
        var receivedModel: TokenFilterScreenModel?
        
        sut.screenModelPublisher
            .dropFirst()
            .sink { model in
                receivedModel = model
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.toggleColor(.white, isSelected: false)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertFalse(receivedModel?.selectedColors.contains(.white) ?? true)
        XCTAssertEqual(receivedModel?.selectedColors.count, 0)
    }
    
    func testToggleColorWhenSelectingColorlessShouldRemoveAllOtherColors() {
        // Given
        sut.toggleColor(.white, isSelected: true)
        sut.toggleColor(.blue, isSelected: true)
        
        let expectation = expectation(description: "Screen model updated")
        var receivedModel: TokenFilterScreenModel?
        
        sut.screenModelPublisher
            .dropFirst()
            .sink { model in
                receivedModel = model
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.toggleColor(.colorless, isSelected: true)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertTrue(receivedModel?.selectedColors.contains(.colorless) ?? false)
        XCTAssertFalse(receivedModel?.selectedColors.contains(.white) ?? true)
        XCTAssertFalse(receivedModel?.selectedColors.contains(.blue) ?? true)
        XCTAssertEqual(receivedModel?.selectedColors.count, 1)
    }
    
    func testToggleColorWhenSelectingColorShouldRemoveColorless() {
        // Given
        sut.toggleColor(.colorless, isSelected: true)
        
        let expectation = expectation(description: "Screen model updated")
        var receivedModel: TokenFilterScreenModel?
        
        sut.screenModelPublisher
            .dropFirst()
            .sink { model in
                receivedModel = model
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.toggleColor(.white, isSelected: true)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertTrue(receivedModel?.selectedColors.contains(.white) ?? false)
        XCTAssertFalse(receivedModel?.selectedColors.contains(.colorless) ?? true)
        XCTAssertEqual(receivedModel?.selectedColors.count, 1)
    }
    
    func testApplyFilterWithNameOnlyShouldCallDelegateWithCorrectUrl() {
        // Given
        sut.updateNameFilter("elf")
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertTrue(delegateMock.receivedFilterUrl?.contains("+name=%22elf%22") ?? false)
        XCTAssertEqual(coordinatorMock.popFilterSceneCallCount, 1)
    }
    
    func testApplyFilterWithColorsOnlyShouldCallDelegateWithCorrectUrl() {
        // Given
        sut.toggleColor(.white, isSelected: true)
        sut.toggleColor(.blue, isSelected: true)
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertTrue(delegateMock.receivedFilterUrl?.contains("+color=WU") ?? false)
        XCTAssertEqual(coordinatorMock.popFilterSceneCallCount, 1)
    }
    
    func testApplyFilterWithNameAndColorsShouldCallDelegateWithCorrectUrl() {
        // Given
        sut.updateNameFilter("elf")
        sut.toggleColor(.white, isSelected: true)
        sut.toggleColor(.red, isSelected: true)
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertTrue(delegateMock.receivedFilterUrl?.contains("+name=%22elf%22") ?? false)
        XCTAssertTrue(delegateMock.receivedFilterUrl?.contains("+color=WR") ?? false)
        XCTAssertEqual(coordinatorMock.popFilterSceneCallCount, 1)
    }
    
    func testApplyFilterWithEmptyFiltersShouldCallDelegateWithBaseUrl() {
        // Given
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertEqual(delegateMock.receivedFilterUrl, Strings.tokenListURL)
        XCTAssertEqual(coordinatorMock.popFilterSceneCallCount, 1)
    }
    
    func testApplyFilterWithWhitespaceNameShouldNotAddNameFilter() {
        // Given
        sut.updateNameFilter("   ")
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertFalse(delegateMock.receivedFilterUrl?.contains("+name") ?? true)
    }
    
    func testApplyFilterWithMultipleColorsShouldOrderThemCorrectly() {
        // Given
        sut.toggleColor(.red, isSelected: true)
        sut.toggleColor(.white, isSelected: true)
        sut.toggleColor(.green, isSelected: true)
        sut.toggleColor(.blue, isSelected: true)
        sut.toggleColor(.black, isSelected: true)
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertTrue(delegateMock.receivedFilterUrl?.contains("+color=WUBRG") ?? false)
    }
    
    func testApplyFilterWithColorlessOnlyShouldCallDelegateWithCorrectUrl() {
        // Given
        sut.toggleColor(.colorless, isSelected: true)
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertTrue(delegateMock.receivedFilterUrl?.contains("+color=C") ?? false)
        XCTAssertEqual(coordinatorMock.popFilterSceneCallCount, 1)
    }
    
    func testUpdateNameFilterWithEmptyStringShouldUpdateScreenModel() {
        // Given
        let expectation = expectation(description: "Screen model updated")
        var receivedModel: TokenFilterScreenModel?
        
        sut.screenModelPublisher
            .dropFirst()
            .sink { model in
                receivedModel = model
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.updateNameFilter("")
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedModel?.nameFilterText, "")
    }
    
    func testToggleColorMultipleTimesShouldMaintainState() {
        // Given
        sut.toggleColor(.white, isSelected: true)
        sut.toggleColor(.blue, isSelected: true)
        sut.toggleColor(.red, isSelected: true)
        
        let expectation = expectation(description: "Screen model updated")
        var receivedModel: TokenFilterScreenModel?
        
        sut.screenModelPublisher
            .dropFirst()
            .sink { model in
                receivedModel = model
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.toggleColor(.blue, isSelected: false)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertTrue(receivedModel?.selectedColors.contains(.white) ?? false)
        XCTAssertTrue(receivedModel?.selectedColors.contains(.red) ?? false)
        XCTAssertFalse(receivedModel?.selectedColors.contains(.blue) ?? true)
        XCTAssertEqual(receivedModel?.selectedColors.count, 2)
    }
    
    func testApplyFilterWithSpecialCharactersInNameShouldEncodeCorrectly() {
        // Given
        sut.updateNameFilter("elf warrior")
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertTrue(delegateMock.receivedFilterUrl?.contains("+name=") ?? false)
    }
    
    func testInitWithNilDelegateShouldNotCrash() {
        // Given
        
        // When
        let viewModel = TokenFilterViewModel(coordinator: coordinatorMock, delegate: nil)
        
        // Then
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.screenModel.nameFilterText, "")
        XCTAssertEqual(viewModel.screenModel.selectedColors.count, 0)
    }
    
    func testApplyFilterWithNilDelegateShouldStillPopScene() {
        // Given
        let viewModel = TokenFilterViewModel(coordinator: coordinatorMock, delegate: nil)
        viewModel.updateNameFilter("test")
        
        // When
        viewModel.applyFilter()
        
        // Then
        XCTAssertEqual(coordinatorMock.popFilterSceneCallCount, 1)
    }
    
    func testToggleColorDeselectingNonSelectedColorShouldNotCrash() {
        // Given
        
        // When
        sut.toggleColor(.white, isSelected: false)
        
        // Then
        XCTAssertEqual(sut.screenModel.selectedColors.count, 0)
    }
    
    func testApplyFilterWithNewlinesInNameShouldTrimCorrectly() {
        // Given
        sut.updateNameFilter("  elf\n  ")
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertTrue(delegateMock.receivedFilterUrl?.contains("+name=%22elf%22") ?? false)
    }
    
    func testApplyFilterWithAllColorsSelectedShouldOrderCorrectly() {
        // Given
        for color in MagicColor.allCases {
            sut.toggleColor(color, isSelected: true)
        }
        
        // When
        sut.applyFilter()
        
        // Then
        XCTAssertEqual(delegateMock.fetchTokensWithFilterCallCount, 1)
        XCTAssertTrue(delegateMock.receivedFilterUrl?.contains("+color=C") ?? false)
    }
    
    func testToggleColorSelectingSameColorTwiceShouldMaintainState() {
        // Given
        sut.toggleColor(.white, isSelected: true)
        
        // When
        sut.toggleColor(.white, isSelected: true)
        
        // Then
        XCTAssertTrue(sut.screenModel.selectedColors.contains(.white))
        XCTAssertEqual(sut.screenModel.selectedColors.count, 1)
    }
    
    func testUpdateNameFilterWithNewlinesShouldUpdateCorrectly() {
        // Given
        
        // When
        sut.updateNameFilter("elf\nwarrior")
        
        // Then
        XCTAssertEqual(sut.screenModel.nameFilterText, "elf\nwarrior")
    }
}

