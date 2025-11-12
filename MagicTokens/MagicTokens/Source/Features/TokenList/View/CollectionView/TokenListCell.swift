//
//  TokenListCell.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit

final class TokenListCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: TokenListCell.self)
    private var currentTask: URLSessionDataTask?
    
    private let imageViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.layer.cornerRadius = frame.height * 0.02
        imageView.layer.masksToBounds = true

        imageViewContainer.layer.shadowColor = UIColor.black.cgColor
        imageViewContainer.layer.shadowOpacity = 0.75
        imageViewContainer.layer.shadowOffset = CGSize(width: 0, height: 3)
        imageViewContainer.layer.shadowRadius = frame.height * 0.02
        imageViewContainer.layer.masksToBounds = false
        
        imageView.image = UIImage(systemName: "photo")?
                   .withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(systemName: "photo")?
                   .withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    }

    private func setupLayout() {
        contentView.addSubview(imageViewContainer)
        imageViewContainer.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor)
        ])
    }

    func configure(with image: UIImage?) {
        imageView.image = image
    }
}
