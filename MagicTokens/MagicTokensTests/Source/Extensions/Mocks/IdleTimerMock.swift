//
//  IdleTimerMock.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

@testable import MagicTokens

final class IdleTimerMock: IdleTimer {
    var isIdleTimerDisabled: Bool = false
}
