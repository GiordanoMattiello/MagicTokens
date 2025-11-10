//
//  TokenDisplayViewController.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit

final class TokenDisplayViewController: UIViewController {
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
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
