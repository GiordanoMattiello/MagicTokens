//
//  UINavigationController+Protocol.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit

public protocol UINavigationControllerProtocol {
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

