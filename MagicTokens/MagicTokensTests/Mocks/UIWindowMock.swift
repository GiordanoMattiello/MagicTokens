//
//  UIWindowMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit
@testable import MagicTokens

final class UIWindowProtocolMock: UIWindowProtocol {
    var rootViewController: UIViewController?
    
    private(set) var makeKeyAndVisibleCallCount = 0
    func makeKeyAndVisible() {
        makeKeyAndVisibleCallCount += 1
    }
}
