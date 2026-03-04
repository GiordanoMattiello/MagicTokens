//
//  UIColor+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import UIKit

extension UIColor {
    func inverted() -> UIColor? {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }
        return nil
    }
}
