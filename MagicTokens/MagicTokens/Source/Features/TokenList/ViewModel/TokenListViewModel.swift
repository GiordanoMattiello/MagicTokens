//
//  TokenListViewModel.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import CommonKit
import Combine
import UIKit

protocol TokenListViewModelProtocol: ObservableObject {
    func fetchTokens(url: String) async
    func fetchNextPageTokens() async
    func loadImageFromURL(url: String) async -> UIImage?
    func didSelectToken(_ token: Token)
    func didTapRightButton()
    
    
    var tokens: [Token] { get set }
    var tokensPublisher: Published<[Token]>.Publisher { get }
    
    var showError: Bool { get set }
    var showErrorPublisher: Published<Bool>.Publisher { get }
}

final class TokenListViewModel: TokenListViewModelProtocol {
    private let adapter: TokenListAdapterProtocol
    private let networkManager: NetworkManagerProtocol
    private let imageCacheManager: ImageCacheManagerProtocol
    private let coordinator: TokenDisplayCoordinator
    
    @Published var tokens: [Token] = []
    var tokensPublisher: Published<[Token]>.Publisher { $tokens }
    
    @Published var showError: Bool = false
    var showErrorPublisher: Published<Bool>.Publisher { $showError }
    
    private var nextPageURL: String?
    
    init(adapter: TokenListAdapterProtocol,
         networkManager: NetworkManagerProtocol,
         imageCacheManager: ImageCacheManagerProtocol,
         coordinator: TokenDisplayCoordinator) {
        self.adapter = adapter
        self.networkManager = networkManager
        self.imageCacheManager = imageCacheManager
        self.coordinator = coordinator
    }
    
    func fetchNextPageTokens() async {
        if let url = nextPageURL {
            await fetchTokens(url: url)
        }
    }
    
    func fetchTokens(url: String) async {
        let request = TokenListRequest(url: nextPageURL ?? url)
        // Todo Ligar Loading
        do {
            let response: TokenListResponse? = try await networkManager.executeRequest(request: request,
                                                                                       transformerType: .json)
            nextPageURL = response?.nextPage
            // Todo desligar Loading
            guard let tokens = response?.tokens else { return }
            self.tokens += tokens.compactMap { [weak self] scryToken in
                self?.adapter.tokenAdapt(scryToken)
            }
        } catch {
            showError = true
            // Todo desligar Loading
        }
    }
    func loadImageFromURL(url: String) async -> UIImage? {
        let request = TokenListImageRequest(url: url)
        if let cachedImage = imageCacheManager.getCache(from: url) {
            return cachedImage
        }
        let dataImage: Data? = try? await networkManager.executeRequest(request: request,
                                                            transformerType: .image)
        
        if let dataImage = dataImage, let image = UIImage(data: dataImage) {
            imageCacheManager.cacheObject(data: image, from: url)
            return image
        }
        return nil
    }
    
    func didSelectToken(_ token: Token) {
        coordinator.navigateToTokenDisplayScene(token: token)
    }
    
    func didTapRightButton() {
        coordinator.navigateToTokenDisplayScene(token: tokens.randomElement()!)
    }
}
