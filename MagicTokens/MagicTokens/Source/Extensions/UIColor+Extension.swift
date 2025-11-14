//
//  UIColor+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import UIKit

extension UIColor {
    func inverted() -> UIColor? {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0

        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0 - r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        
        return nil
    }
}
