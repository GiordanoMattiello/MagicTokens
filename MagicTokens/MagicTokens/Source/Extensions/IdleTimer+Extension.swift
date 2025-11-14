//
//  IdleTimer+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import UIKit

protocol IdleTimer {
    var isIdleTimerDisabled: Bool { get set }
}

extension UIApplication: IdleTimer {}
