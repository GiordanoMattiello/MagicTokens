//
//  MagicColor.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit

enum MagicColor: String, CaseIterable {
    case white = "W"
    case blue = "U"
    case black = "B"
    case red = "R"
    case green = "G"
    case colorless = "C"
    
    var displayName: String {
        switch self {
        case .white: return "Branco"
        case .blue: return "Azul"
        case .black: return "Preto"
        case .red: return "Vermelho"
        case .green: return "Verde"
        case .colorless: return "Incolor"
        }
    }
    
    var uiColor: UIColor {
        switch self {
        case .white: return UIColor(white: 0.95, alpha: 1.0)
        case .blue: return .systemBlue
        case .black: return UIColor(white: 0.1, alpha: 1.0)
        case .red: return .systemRed
        case .green: return .systemGreen
        case .colorless: return .systemGray
        }
    }
}

