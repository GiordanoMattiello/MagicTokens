//
//  TokenDisplayView.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit

protocol TokenDisplayViewProtocol where Self: UIView  {
    func configure(model: TokenDisplayScreenModel)
}

final class TokenDisplayView: UIView, TokenDisplayViewProtocol {
    // MARK: - SubViews
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "tokenImageView"
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Imagem do token"
        imageView.alpha = 0
        return imageView
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    func configure(model: TokenDisplayScreenModel) {
        let processedImage = processImage(model.image)
        self.imageView.image = processedImage
        self.imageView.accessibilityLabel = "\(model.token.name)"
        
        if model.isLoading {
            loadingView.show()
            imageView.alpha = 0
        } else {
            loadingView.hide()
            if processedImage != nil {
                animateImageAppearance()
            }
        }
    }
    
    private func animateImageAppearance() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.imageView.alpha = 1.0
        }
    }
    
    private func processImage(_ image: UIImage?) -> UIImage? {
        image?.withRoundedCorners(radius: calculateCornerRadius())
    }
    
    private func calculateCornerRadius() -> CGFloat {
        return  bounds.width  * Constants.cardBorderProportion
    }
    
    // MARK: - Private Methods
    
    private func setupSubViews() {
        addSubview(imageView)
        addSubview(loadingView)
        bringSubviewToFront(loadingView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
