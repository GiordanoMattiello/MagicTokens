//
//  TokenDisplayView.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit

protocol TokenDisplayViewProtocol where Self: UIView  {
    func configure(image: UIImage?)
}

final class TokenDisplayView: UIView, TokenDisplayViewProtocol {
    
    private let cardProportion = 0.71568627451
    
    // MARK: - SubViews
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        setupSubViews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?) {
        if let image = image {
            let roundedImage = image.withRoundedCorners(radius: calculateCornerRadius())
            self.imageView.image = roundedImage
        } else {
            self.imageView.image = nil
        }
    }
    
    private func calculateCornerRadius() -> CGFloat {
        return (bounds.width * 0.075)
    }
    
    // MARK: - Private Methods
    
    private func setupSubViews() {
        addSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
