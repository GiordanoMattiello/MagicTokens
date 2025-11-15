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

    func configure(model: TokenDisplayScreenModel) {
        self.imageView.image = processImage(model.image)
        // TODO: - Make accessibilityLabel from token data like "elf - warrior power: 1/ tougnes: 1"
        self.imageView.accessibilityLabel = "Imagem carregada"
    }
    
    private func processImage(_ image: UIImage?) -> UIImage? {
        image?.withRoundedCorners(radius: calculateCornerRadius())
    }
    
    private func calculateCornerRadius() -> CGFloat {
        let width = bounds.width > 0 ? bounds.width : frame.width
        guard width > 0 else {
            return Constants.cardBorderProportion * 100
        }
        return width * Constants.cardBorderProportion
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
