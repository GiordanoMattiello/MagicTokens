//
//  TokenFilterViewModelMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

@testable import MagicTokens
import Combine
import UIKit

class TokenFilterViewModelMock: TokenFilterViewModelProtocol {
    private(set) var applyFilterCallCount = 0
    func applyFilter() {
        applyFilterCallCount += 1
    }
    
    private(set) var updateNameFilterCallCount = 0
    private(set) var updateNameFilterReceivedText: String?
    func updateNameFilter(_ text: String) {
        updateNameFilterCallCount += 1
        updateNameFilterReceivedText = text
    }
    
    private(set) var toggleColorCallCount = 0
    private(set) var toggleColorReceivedColor: MagicColor?
    private(set) var toggleColorReceivedIsSelected: Bool?
    func toggleColor(_ color: MagicColor, isSelected: Bool) {
        toggleColorCallCount += 1
        toggleColorReceivedColor = color
        toggleColorReceivedIsSelected = isSelected
    }
    
    @Published var screenModel: TokenFilterScreenModel = TokenFilterScreenModel()
    var screenModelPublisher: Published<TokenFilterScreenModel>.Publisher { $screenModel }
}


