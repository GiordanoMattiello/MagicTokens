//
//  AlertErrorModel+Stub.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

@testable import MagicTokens

extension AlertErrorModel {
    static func stub(title: String = "Test Title",
                     message: String = "Test Message",
                     primaryButtonTitle: String = "OK",
                     secondaryButtonTitle: String? = "Retry",
                     primaryCompletion: (() -> Void)? = nil,
                     secondaryCompletion: (() -> Void)? = nil) -> AlertErrorModel {
        return AlertErrorModel(title: title,
                               message: message,
                               primaryButtonTitle: primaryButtonTitle,
                               secondaryButtonTitle: secondaryButtonTitle,
                               primaryCompletion: primaryCompletion,
                               secondaryCompletion: secondaryCompletion
        )
    }

}
