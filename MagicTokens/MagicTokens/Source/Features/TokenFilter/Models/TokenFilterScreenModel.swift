//
//  TokenFilterScreenModel.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation

struct TokenFilterScreenModel {
    let isButtonEnabled: Bool
    let nameFilterText: String
    let selectedColors: Set<MagicColor>
    
    init(isButtonEnabled: Bool = true, nameFilterText: String = "", selectedColors: Set<MagicColor> = []) {
        self.isButtonEnabled = isButtonEnabled
        self.nameFilterText = nameFilterText
        self.selectedColors = selectedColors
    }
}

