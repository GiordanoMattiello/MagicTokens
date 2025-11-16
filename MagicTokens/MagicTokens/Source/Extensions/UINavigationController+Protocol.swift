//
//  UINavigationController+Protocol.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit

public protocol UINavigationControllerProtocol {
    var topViewController: UIViewController? { get }
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    @discardableResult func popViewController(animated: Bool) -> UIViewController?
}

