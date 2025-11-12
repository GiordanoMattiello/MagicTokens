//
//  TokenListViewController.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit
import CommonKit
import Combine

protocol TokenListViewControllerDelegate: AnyObject {
    func loadImageFromURL(url: String) async throws -> UIImage?
    func fetchNextPageTokens() async
    func didSelectToken(_ token: Token)
}

final class TokenListViewController: UIViewController {
    private let url = "https://api.scryfall.com/cards/search?q=type=token"
    private let contentView: TokenListViewProtocol
    private var viewModel: any TokenListViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(contentView: TokenListViewProtocol,
         viewModel: any TokenListViewModelProtocol) {
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
        title = "Magic Tokens"
        contentView.delegate = self
        setupBindings()
        fetchTokens()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRightBarButton()
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func setupBindings() {
        viewModel.tokensPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] tokens in
                self?.contentView.updateTokens(tokens)
            }
            .store(in: &cancellables)
        
        viewModel.showErrorPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] showError in
                if showError {
                    self?.showErrorAlert(message: "Não foi possível carregar os tokens.",
                                   secondaryCompletion: { [weak self] in
                        self?.fetchTokens()
                        self?.viewModel.showError = false
                    })
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchTokens() {
        Task {
            await viewModel.fetchTokens(url: url)
        }
    }
    
    private func setupRightBarButton() {
        let rightButton = UIBarButtonItem(
            title: "Filtro",
            style: .plain,
            target: self,
            action: #selector(rightButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func rightButtonTapped(){
        viewModel.didTapRightButton()
    }
    
}

extension TokenListViewController: TokenListViewControllerDelegate {
    func loadImageFromURL(url: String) async throws -> UIImage? {
        await viewModel.loadImageFromURL(url: url)
    }
    
    func fetchNextPageTokens() async {
        await viewModel.fetchNextPageTokens()
    }
    
    func didSelectToken(_ token: Token) {
        viewModel.didSelectToken(token)
    }
}
