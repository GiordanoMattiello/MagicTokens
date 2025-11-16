//
//  TokenFilterView.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit

protocol TokenFilterViewProtocol where Self: UIView {
    func configure(model: TokenFilterScreenModel)
}

protocol TokenFilterViewDelegate: AnyObject {
    func didTapApplyFilter()
    func didChangeNameFilter(_ text: String)
    func didToggleColor(_ color: MagicColor, isSelected: Bool)
}

final class TokenFilterView: UIView, TokenFilterViewProtocol, UITextFieldDelegate {
    weak var delegate: TokenFilterViewDelegate?
    // MARK: - SubViews
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorsLabel: UILabel = {
        let label = UILabel()
        label.text = "Cores"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var colorCheckboxes: [MagicColor: MagicColorCheckboxView] = [:]
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome do token"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "nameTextField"
        textField.isAccessibilityElement = true
        textField.accessibilityLabel = "Campo de texto para filtrar por nome do token"
        textField.returnKeyType = .done
        return textField
    }()
    
    private let applyFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Aplicar Filtro", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "applyFilterButton"
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Aplicar filtro"
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        nameTextField.delegate = self
        setupColorCheckboxes()
        setupSubViews()
        setupConstraints()
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: TokenFilterScreenModel) {
        applyFilterButton.isEnabled = model.isButtonEnabled
        applyFilterButton.alpha = model.isButtonEnabled ? 1.0 : 0.5
        nameTextField.text = model.nameFilterText
        
        for (color, checkbox) in colorCheckboxes {
            let isSelected = model.selectedColors.contains(color)
            checkbox.configure(isSelected: isSelected)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupActions() {
        applyFilterButton.addAction(UIAction { [weak self] _ in
            self?.delegate?.didTapApplyFilter()
        }, for: .touchUpInside)
        
        nameTextField.addAction(UIAction { [weak self] _ in
            self?.delegate?.didChangeNameFilter(self?.nameTextField.text ?? "")
        }, for: .editingChanged)
        
        for (color, checkbox) in colorCheckboxes {
            checkbox.setToggleAction { [weak self] in
                guard let self = self else { return }
                let currentState = checkbox.isSelected
                let newState = !currentState
                checkbox.configure(isSelected: newState)
                self.delegate?.didToggleColor(color, isSelected: newState)
            }
        }
    }
    
    private func setupColorCheckboxes() {
        for color in MagicColor.allCases {
            let checkbox = MagicColorCheckboxView(color: color)
            colorCheckboxes[color] = checkbox
            colorsStackView.addArrangedSubview(checkbox)
        }
    }
    
    private func setupSubViews() {
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(colorsLabel)
        addSubview(colorsStackView)
        addSubview(applyFilterButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            nameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            colorsLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            colorsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            colorsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            colorsStackView.topAnchor.constraint(equalTo: colorsLabel.bottomAnchor, constant: 12),
            colorsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            colorsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            applyFilterButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            applyFilterButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            applyFilterButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            applyFilterButton.heightAnchor.constraint(equalToConstant: 50),
            applyFilterButton.topAnchor.constraint(greaterThanOrEqualTo: colorsStackView.bottomAnchor, constant: 20)
        ])
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

