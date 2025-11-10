//
//  TokenListViewController.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit

final class TokenListViewController: UIViewController {
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    override func loadView() {
        view = contentView
    }
}
