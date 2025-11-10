//
//  UINavigationController+Protocol.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//
import UIKit

protocol UINavigationControllerProtocol {
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
}

extension UINavigationController: UINavigationControllerProtocol {}

