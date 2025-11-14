//
//  UIAlertController+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import UIKit
@testable import MagicTokens

extension UIAlertController {
    typealias AlertHandler = @convention(block) (UIAlertAction) -> Void

    func tapButton(atIndex index: Int) {
        guard let block = actions[safe: index]?.value(forKey: "handler") else { return }
        let handler = unsafeBitCast(block as AnyObject, to: AlertHandler.self)
        handler(actions[index])
    }
}
