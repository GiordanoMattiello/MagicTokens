//
//  UIViewController+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 12/11/25.
//

import UIKit

extension UIViewController {
    func showErrorAlert(
        title: String = "Erro",
        message: String,
        primaryButtonTitle: String = "OK",
        secondaryButtonTitle: String = "Tentar novamente",
        primaryCompletion: (() -> Void)? = nil,
        secondaryCompletion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let primaryAction = UIAlertAction(title: primaryButtonTitle, style: .default) { _ in
            primaryCompletion?()
        }
        
        let secondaryAction = UIAlertAction(title: secondaryButtonTitle, style: .default) { _ in
            secondaryCompletion?()
        }
        
        alert.addAction(primaryAction)
        alert.addAction(secondaryAction)
    
        
        present(alert, animated: true)
    }
}
