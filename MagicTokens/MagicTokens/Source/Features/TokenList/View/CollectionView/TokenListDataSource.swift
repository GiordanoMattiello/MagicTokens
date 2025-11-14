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
    private var tokens: [Token] = []
    weak var delegate: TokenListViewControllerDelegate?
    
    func updateTokens(_ tokens: [Token]) {
        self.tokens = tokens
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tokens.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TokenListCell.reuseIdentifier, for: indexPath) as? TokenListCellProtocol else {
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
        let width = Constants.smallCardWidth
        return CGSize(width: width, height: width / Constants.cardProportion )
    }
    
    private func loadImage(with imageUrl: String, completion: @escaping (UIImage)->Void ) {
        Task {
            let image: UIImage? = try? await delegate?.loadImageFromURL(url: imageUrl)
            guard let image = image else {return}
            await MainActor.run {
                completion(image)
            }
        }
    }
}
