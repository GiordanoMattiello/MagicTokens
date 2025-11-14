//
//  AlertErrorModel.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import UIKit

struct AlertErrorModel {
    let title: String
    let message: String
    let primaryButtonTitle: String
    let secondaryButtonTitle: String?
    let primaryCompletion: (() -> Void)?
    let secondaryCompletion: (() -> Void)?
    
    init(title: String = "Erro",
          message: String,
          primaryButtonTitle: String = "OK",
          secondaryButtonTitle: String? = nil,
          primaryCompletion: (() -> Void)? = nil,
         secondaryCompletion: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.primaryCompletion = primaryCompletion
        self.secondaryCompletion = secondaryCompletion
    }

}
