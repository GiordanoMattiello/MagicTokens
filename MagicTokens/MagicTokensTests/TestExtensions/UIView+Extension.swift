//
//  UIView+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import UIKit

extension UIView {
    func findView(withAccessibilityIdentifier identifier: String) -> UIView? {
        if self.accessibilityIdentifier == identifier {
            return self
        }
        
        for subview in subviews {
            if let foundView = subview.findView(withAccessibilityIdentifier: identifier) {
                return foundView
            }
        }
        
        return nil
    }
}
