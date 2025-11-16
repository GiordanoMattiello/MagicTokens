//
//  TokenListView.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit

protocol TokenListViewProtocol where Self: UIView {
    func configure(model: TokenListScreenModel)
    var delegate: TokenListViewControllerDelegate? { get set }
}

final class TokenListView: UIView, TokenListViewProtocol {
    private let dataSource: TokenListDataSourceProtocol
    weak var delegate: TokenListViewControllerDelegate? {
        didSet {
            dataSource.delegate = delegate
        }
    }
    
    // MARK: - SubViews
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    init(dataSource: TokenListDataSourceProtocol = TokenListDataSource()) {
        self.dataSource = dataSource
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        
        setupSubViews()
        setupLayout()
        setupConstraints()
        setupCollectionViewDelegate(dataSource)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: TokenListScreenModel) {
        dataSource.updateTokens(model.tokens)
        reloadView()
        
        if model.isLoading {
            loadingView.show()
        } else {
            self.loadingView.hide()
        }
    }
    
    // MARK: - Private Methods
    
    private func reloadView() {
        Task { @MainActor [weak self]  in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupSubViews() {
        addSubview(collectionView)
        addSubview(loadingView)
        bringSubviewToFront(loadingView)
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.collectionViewLayout = layout
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCollectionViewDelegate(_ dataSource: TokenListDataSourceProtocol) {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.register(TokenListCell.self, forCellWithReuseIdentifier: TokenListCell.reuseIdentifier)
    }
}
