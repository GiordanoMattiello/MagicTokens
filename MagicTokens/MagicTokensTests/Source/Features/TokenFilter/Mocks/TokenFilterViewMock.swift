//
//  TokenFilterViewMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

@testable import MagicTokens
import UIKit

class TokenFilterViewMock: UIView, TokenFilterViewProtocol {
    private(set) var configureCallCount = 0
    private(set) var receivedScreenModel: TokenFilterScreenModel?
    var onCompleteConfigure: (()->Void)?
    func configure(model: TokenFilterScreenModel) {
        configureCallCount += 1
        receivedScreenModel = model
        onCompleteConfigure?()
    }
    
    private(set) var setApplyFilterActionCallCount = 0
    var applyFilterAction: (()->Void)?
    func setApplyFilterAction(_ action: @escaping () -> Void) {
        setApplyFilterActionCallCount += 1
        applyFilterAction = action
    }
    
    private(set) var setNameFilterTextChangeActionCallCount = 0
    var nameFilterTextChangeAction: ((String) -> Void)?
    func setNameFilterTextChangeAction(_ action: @escaping (String) -> Void) {
        setNameFilterTextChangeActionCallCount += 1
        nameFilterTextChangeAction = action
    }
    
    private(set) var getNameFilterTextCallCount = 0
    var getNameFilterTextReturnValue: String = ""
    func getNameFilterText() -> String {
        getNameFilterTextCallCount += 1
        return getNameFilterTextReturnValue
    }
    
    private(set) var setColorToggleActionCallCount = 0
    var colorToggleAction: ((MagicColor, Bool) -> Void)?
    func setColorToggleAction(_ action: @escaping (MagicColor, Bool) -> Void) {
        setColorToggleActionCallCount += 1
        colorToggleAction = action
    }
}


