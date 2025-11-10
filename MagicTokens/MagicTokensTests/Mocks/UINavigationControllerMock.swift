//
//  UINavigationControllerMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit
@testable import MagicTokens

class UINavigationControllerMock: UINavigationControllerProtocol {
    private(set) var setViewControllersCallCount = 0
    private(set) var receivedViewControllers: [UIViewController]?
    private(set) var receivedAnimated: Bool?
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        receivedViewControllers = viewControllers
        receivedAnimated = animated
        setViewControllersCallCount += 1
    }
}
