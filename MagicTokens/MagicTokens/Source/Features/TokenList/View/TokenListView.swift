//
//  TokenListView.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit

protocol TokenListViewProtocol where Self: UIView {
    func reloadView()
    func updateTokens(_ tokens: [Token])
    
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
    
    func reloadView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func updateTokens(_ tokens: [Token]) {
        dataSource.updateTokens(tokens)
        reloadView()
    }
    
    // MARK: - Private Methods
    
    private func setupSubViews() {
        addSubview(collectionView)
    }
    
    private func setupLayout() {
        configureCollectionViewLayout()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupCollectionViewDelegate(_ dataSource: TokenListDataSourceProtocol) {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.register(TokenListCell.self, forCellWithReuseIdentifier: TokenListCell.reuseIdentifier)
    }
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.collectionViewLayout = layout
    }
}
