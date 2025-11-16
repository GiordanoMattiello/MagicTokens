//
//  TokenFilterViewModel.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit
import Combine

protocol TokenFilterViewModelProtocol {
    func applyFilter()
    func updateNameFilter(_ text: String)
    func toggleColor(_ color: MagicColor, isSelected: Bool)
    
    var screenModel: TokenFilterScreenModel { get }
    var screenModelPublisher: Published<TokenFilterScreenModel>.Publisher { get }
}

final class TokenFilterViewModel: TokenFilterViewModelProtocol {
    private let coordinator: AlertErrorCoordinator & TokenFilterCoordinator
    private weak var delegate: ApplyFilterDelegate?
    private var nameFilterText: String = ""
    private var selectedColors: Set<MagicColor> = []
    
    @Published private(set) var screenModel: TokenFilterScreenModel
    var screenModelPublisher: Published<TokenFilterScreenModel>.Publisher { $screenModel }
    
    init(coordinator: AlertErrorCoordinator & TokenFilterCoordinator,
         delegate: ApplyFilterDelegate?) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.screenModel = TokenFilterScreenModel()
    }
    
    func updateNameFilter(_ text: String) {
        nameFilterText = text
        screenModel = TokenFilterScreenModel(nameFilterText: text, selectedColors: selectedColors)
    }
    
    func toggleColor(_ color: MagicColor, isSelected: Bool) {
        if isSelected {
            if color == .colorless {
                selectedColors.removeAll()
                selectedColors.insert(.colorless)
            } else {
                selectedColors.remove(.colorless)
                selectedColors.insert(color)
            }
        } else {
            selectedColors.remove(color)
        }
        screenModel = TokenFilterScreenModel(nameFilterText: nameFilterText, selectedColors: selectedColors)
    }
    
    func applyFilter() {
        var filterUrl = Strings.tokenListURL
        
        if !nameFilterText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let trimmedName = nameFilterText.trimmingCharacters(in: .whitespacesAndNewlines)
            let encodedName = trimmedName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? trimmedName
            let filterQuery = "+name=%22\(encodedName)%22"
            filterUrl += filterQuery
        }
        
        if !selectedColors.isEmpty {
            let colorOrder: [MagicColor] = [.white, .blue, .black, .red, .green, .colorless]
            let sortedColors = selectedColors.sorted { color1, color2 in
                let index1 = colorOrder.firstIndex(of: color1) ?? Int.max
                let index2 = colorOrder.firstIndex(of: color2) ?? Int.max
                return index1 < index2
            }
            let colorString = sortedColors.map { $0.rawValue }.joined()
            filterUrl += "+color=\(colorString)"
        }
        
        delegate?.fetchTokensWithFilter(filterUrl: filterUrl)
        coordinator.popFilterScene()
    }
}

