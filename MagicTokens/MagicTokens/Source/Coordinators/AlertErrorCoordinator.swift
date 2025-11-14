//
//  AlertErrorCoordinator.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 13/11/25.
//

import UIKit

protocol AlertErrorCoordinator {
    func presentAlert(alertModel: AlertErrorModel)
}

extension AppCoordinator: AlertErrorCoordinator {
    func presentAlert(alertModel: AlertErrorModel){
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert
        )
        
        let primaryAction = UIAlertAction(title: alertModel.primaryButtonTitle, style: .default) { _ in
            alertModel.primaryCompletion?()
        }
        alert.addAction(primaryAction)
         
        if let secondaryTitle = alertModel.secondaryButtonTitle {
            let secondaryAction = UIAlertAction(title: secondaryTitle, style: .default) { _ in
                alertModel.secondaryCompletion?()
            }
            alert.addAction(secondaryAction)
        }
        navigationController.present(alert, animated: true, completion: {})
    }
}
