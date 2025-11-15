//
//  TokenDisplayViewController.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit
import CommonKit
import Combine

final class TokenDisplayViewController: UIViewController {
    private var viewModel: any TokenDisplayViewModelProtocol
    private let contentView: TokenDisplayViewProtocol
    private var idleTimer: IdleTimer
    private var cancellables = Set<AnyCancellable>()
    
    init(contentView: TokenDisplayViewProtocol,
         viewModel: any TokenDisplayViewModelProtocol,
         idleTimer: IdleTimer = UIApplication.shared) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.idleTimer = idleTimer
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBindings()
        
        viewModel.loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        idleTimer.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        idleTimer.isIdleTimerDisabled = false
    }
    
    override func loadView() {
        view = contentView
    }
    
    deinit {
        idleTimer.isIdleTimerDisabled = false
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = viewModel.screenModel.token.name
    }
    
    private func setupBindings() {
        viewModel.screenModelPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                self?.contentView.configure(model: model)
            }
            .store(in: &cancellables)
    }
}
