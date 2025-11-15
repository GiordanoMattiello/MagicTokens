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
    func fetchTokensWithFilter(url: String) async
    func loadImageFromURL(url: String) async -> UIImage?
    func didSelectToken(_ token: Token)
    func didTapRightButton()
    
    var screenModel: TokenListScreenModel { get }
    var screenModelPublisher: Published<TokenListScreenModel>.Publisher { get }
}

final class TokenListViewModel: TokenListViewModelProtocol {
    private let adapter: TokenListAdapterProtocol
    private let networkManager: NetworkServiceProtocol
    private let imageCacheManager: ImageCacheManagerProtocol
    private let coordinator: TokenDisplayCoordinator & AlertErrorCoordinator
    
    @Published private(set) var screenModel: TokenListScreenModel
    var screenModelPublisher: Published<TokenListScreenModel>.Publisher { $screenModel }
    
    private var nextPageURL: String?
    private var isLoadingNextPage: Bool = false
    
    init(adapter: TokenListAdapterProtocol,
         networkManager: NetworkServiceProtocol,
         imageCacheManager: ImageCacheManagerProtocol,
         coordinator: TokenDisplayCoordinator & AlertErrorCoordinator,
         screenModel: TokenListScreenModel = TokenListScreenModel()) {
        self.adapter = adapter
        self.networkManager = networkManager
        self.imageCacheManager = imageCacheManager
        self.coordinator = coordinator
        self.screenModel = screenModel
    }
    
    func fetchNextPageTokens() async {
        guard !isLoadingNextPage, let url = nextPageURL else { return }
        isLoadingNextPage = true
        await fetchTokens(url: url)
        isLoadingNextPage = false
    }
    
    func fetchTokensWithFilter(url: String) async {
        updateScreenModel(tokens: [], isLoading: true, replaceTokens: true)
        nextPageURL = nil
        await fetchTokens(url: url)
    }
    
    
    @MainActor
    func fetchTokens(url: String) async {
        let request = TokenListRequest(url: url)
        updateScreenModel(isLoading: true)
        do {
            let response: TokenListResponse? = try await networkManager.executeRequest(request: request)
            nextPageURL = response?.nextPage
            guard let tokens = response?.tokens else {
                updateScreenModel(isLoading: false)
                return
            }
            let adaptedTokens = tokens.compactMap { [weak self] scryToken in
                self?.adapter.tokenAdapt(scryToken)
            }
            updateScreenModel(tokens: adaptedTokens, isLoading: false)
        } catch {
            updateScreenModel(isLoading: false)
            presentError()
        }
    }
    
    func loadImageFromURL(url: String) async -> UIImage? {
        let request = TokenListImageRequest(url: url)
        if let cachedImage = imageCacheManager.getCache(from: url) {
            return cachedImage
        }
        let dataImage: Data? = try? await networkManager.executeRequest(request: request)
        
        if let dataImage = dataImage, let image = UIImage(data: dataImage) {
            imageCacheManager.cacheObject(data: image, from: url)
            return image
        }
        return nil
    }
    
    private func presentError() {
        let alertModel = AlertErrorModel(message: "Erro ao carregar os tokens.",
            secondaryButtonTitle: "Tentar novamente",
            primaryCompletion: nil,
            secondaryCompletion: { [weak self] in
                self?.tryAgain()
            })
        self.coordinator.presentAlert(alertModel: alertModel)
    }
    
    func didSelectToken(_ token: Token) {
        coordinator.navigateToTokenDisplayScene(token: token)
    }
    
    func didTapRightButton() {

    }
    
    private func tryAgain() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            self.updateScreenModel(tokens: [], isLoading: true, replaceTokens: true)
            await self.fetchTokens(url: Strings.tokenListURL)
        }
    }
    
    private func updateScreenModel(tokens: [Token]? = nil, isLoading: Bool, replaceTokens: Bool = false) {
        if let tokens = tokens {
            if replaceTokens {
                self.screenModel = TokenListScreenModel(tokens: tokens, isLoading: isLoading)
            } else {
                self.screenModel.tokens += tokens
            }
        }
        self.screenModel.isLoading = isLoading
    }
}
