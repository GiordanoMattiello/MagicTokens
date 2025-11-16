//
//  TokenFilterViewDelegateMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

@testable import MagicTokens

final class TokenFilterViewDelegateMock: TokenFilterViewDelegate {
    private(set) var didTapApplyFilterCallCount = 0
    var onDidTapApplyFilter: (() -> Void)?
    func didTapApplyFilter() {
        didTapApplyFilterCallCount += 1
        onDidTapApplyFilter?()
    }
    
    private(set) var didChangeNameFilterCallCount = 0
    private(set) var didChangeNameFilterReceivedText: String?
    var onDidChangeNameFilter: ((String) -> Void)?
    func didChangeNameFilter(_ text: String) {
        didChangeNameFilterCallCount += 1
        didChangeNameFilterReceivedText = text
        onDidChangeNameFilter?(text)
    }
    
    private(set) var didToggleColorCallCount = 0
    private(set) var didToggleColorReceivedColor: MagicColor?
    private(set) var didToggleColorReceivedIsSelected: Bool?
    var onDidToggleColor: ((MagicColor, Bool) -> Void)?
    func didToggleColor(_ color: MagicColor, isSelected: Bool) {
        didToggleColorCallCount += 1
        didToggleColorReceivedColor = color
        didToggleColorReceivedIsSelected = isSelected
        onDidToggleColor?(color, isSelected)
    }
}

