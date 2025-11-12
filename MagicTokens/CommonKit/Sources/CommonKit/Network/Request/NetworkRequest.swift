//
//  Request.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 11/11/25.
//

import Foundation

public protocol NetworkRequest {
    var url: String { get }
    var method: NetworkMethod { get }
}
