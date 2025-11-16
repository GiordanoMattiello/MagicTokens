//
//  LoadingView.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 15/11/25.
//

import UIKit

final class LoadingView: UIView {
    // MARK: - SubViews
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.9)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .label
        indicator.accessibilityIdentifier = "loadingActivityIndicator"
        indicator.isAccessibilityElement = true
        indicator.accessibilityLabel = "Carregando"
        return indicator
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.isHidden = true
        setupSubViews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hide() {
        isHidden = true
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Private Methods
    
    private func setupSubViews() {
        addSubview(containerView)
        containerView.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 100),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

