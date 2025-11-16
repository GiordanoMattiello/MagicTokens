//
//  TokenFilterViewController.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit
import Combine

final class TokenFilterViewController: UIViewController {
    private var viewModel: any TokenFilterViewModelProtocol
    private let contentView: TokenFilterViewProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(contentView: TokenFilterViewProtocol,
         viewModel: any TokenFilterViewModelProtocol) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        if let filterView = contentView as? TokenFilterView {
            filterView.delegate = self
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBindings()
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = "Filtros"
    }
    
    private func setupBindings() {
        viewModel.screenModelPublisher
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] model in
                self?.contentView.configure(model: model)
            }
            .store(in: &cancellables)
        
        contentView.configure(model: viewModel.screenModel)
    }
}

extension TokenFilterViewController: TokenFilterViewDelegate {
    func didTapApplyFilter() {
        viewModel.applyFilter()
    }
    
    func didChangeNameFilter(_ text: String) {
        viewModel.updateNameFilter(text)
    }
    
    func didToggleColor(_ color: MagicColor, isSelected: Bool) {
        viewModel.toggleColor(color, isSelected: isSelected)
    }
}

