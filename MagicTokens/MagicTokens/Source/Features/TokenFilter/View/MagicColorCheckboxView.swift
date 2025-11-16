//
//  ColorCheckboxView.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit

protocol MagicColorCheckboxViewProtocol where Self: UIView {
    func configure(isSelected: Bool)
    func setToggleAction(_ action: @escaping () -> Void)
    var isSelected: Bool { get }
}

final class MagicColorCheckboxView: UIView, MagicColorCheckboxViewProtocol {
    private let color: MagicColor
    private(set) var isSelected: Bool = false
    
    private let checkboxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    private let colorDot: UIView = {
        let dot = UIView()
        dot.translatesAutoresizingMaskIntoConstraints = false
        dot.layer.cornerRadius = 10
        dot.layer.borderWidth = 1
        dot.layer.borderColor = UIColor.separator.cgColor
        dot.isUserInteractionEnabled = false
        return dot
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(color: MagicColor) {
        self.color = color
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(isSelected: Bool) {
        self.isSelected = isSelected
        checkboxImageView.image = isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
    }
    
    func setToggleAction(_ action: @escaping () -> Void) {
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)
    }
    
    private func setupView() {
        colorDot.backgroundColor = color.uiColor
        titleLabel.text = "\(color.displayName) (\(color.rawValue))"
        
        button.accessibilityIdentifier = "colorCheckbox_\(color.rawValue)"
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Filtrar por cor \(color.displayName)"
        
        addSubview(button)
        button.addSubview(checkboxImageView)
        button.addSubview(colorDot)
        button.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 44),
            
            checkboxImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            checkboxImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            checkboxImageView.widthAnchor.constraint(equalToConstant: 20),
            checkboxImageView.heightAnchor.constraint(equalToConstant: 20),
            
            colorDot.leadingAnchor.constraint(equalTo: checkboxImageView.trailingAnchor, constant: 12),
            colorDot.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            colorDot.widthAnchor.constraint(equalToConstant: 20),
            colorDot.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: colorDot.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: button.trailingAnchor)
        ])
    }
}

