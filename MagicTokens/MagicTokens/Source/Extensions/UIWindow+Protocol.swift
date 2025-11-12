//
//  UIWindow+Protocol.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit

public protocol UIWindowProtocol {
    func makeKeyAndVisible()
    var rootViewController: UIViewController? { get set }
}

extension UIWindow: UIWindowProtocol{}
