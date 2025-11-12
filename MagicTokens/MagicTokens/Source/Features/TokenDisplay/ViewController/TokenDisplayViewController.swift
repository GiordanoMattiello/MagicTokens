//
//  TokenDisplayViewController.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit

final class TokenDisplayViewController: UIViewController {
    private var viewModel: TokenDisplayViewModelProtocol
    private let contentView: TokenDisplayViewProtocol
    
    init(contentView: TokenDisplayViewProtocol,
         viewModel: TokenDisplayViewModelProtocol) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = viewModel.token.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImage()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func loadView() {
        view = contentView
    }
    
    deinit {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    private func loadImage() {
        Task {
            let image = await viewModel.loadLargeImage()
            await MainActor.run {
                contentView.configure(image: image)
            }
        }
    }
}
