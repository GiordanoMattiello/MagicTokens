//
//  UINavigationControllerMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit
@testable import MagicTokens

class UINavigationControllerMock: UINavigationControllerProtocol {
    private(set) var pushViewControllerCallCount = 0
    private(set) var receivedPushViewController: UIViewController?
    private(set) var receivedPushAnimated: Bool?
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCallCount += 1
        receivedPushViewController = viewController
        receivedPushAnimated = animated
    }
    
    private(set) var setViewControllersCallCount = 0
    private(set) var receivedSetViewControllers: [UIViewController]?
    private(set) var receivedSetAnimated: Bool?
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        receivedSetViewControllers = viewControllers
        receivedSetAnimated = animated
        setViewControllersCallCount += 1
    }
    
    private(set) var presentCallCount = 0
    private(set) var receivedViewControllerToPresent: UIViewController?
    private(set) var receivedPresentAnimated: Bool?
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        presentCallCount += 1
        receivedViewControllerToPresent = viewControllerToPresent
        receivedPresentAnimated = flag
        completion?()
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        presentCallCount += 1
        receivedViewControllerToPresent = viewControllerToPresent
        receivedPresentAnimated = flag
    }
}
