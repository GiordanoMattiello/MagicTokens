//
//  TokenListDataSource.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 10/11/25.
//

import UIKit

protocol TokenListDataSourceProtocol: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func updateTokens(_ tokens: [Token])
    var delegate: TokenListViewControllerDelegate? { get set }
}

final class TokenListDataSource: NSObject, TokenListDataSourceProtocol {
    private let cardProportion = 0.71568627451
    private var tokens: [Token] = []
    weak var delegate: TokenListViewControllerDelegate?
    
    func updateTokens(_ tokens: [Token]) {
        self.tokens = tokens
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tokens.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TokenListCell.reuseIdentifier, for: indexPath) as? TokenListCell else {
            return UICollectionViewCell()
        }
        self.loadImage(with: tokens[indexPath.row].smallImageURL) { image in
            cell.configure(with: image)
        }
        
        if tokens.count - 1 == indexPath.row {
            Task {
                await delegate?.fetchNextPageTokens()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedToken = tokens[indexPath.row]
        delegate?.didSelectToken(selectedToken)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 146.0
        return CGSize(width: 146, height: width / cardProportion )
    }
    
    private func loadImage(with imageUrl: String, completion: @escaping (UIImage)->Void ) {
        Task {
            do {
                let image: UIImage? = try await delegate?.loadImageFromURL(url: imageUrl)
                guard let image = image else {return}
                await MainActor.run {
                    completion(image)
                }
            }
        }
    }
}
