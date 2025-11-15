//
//  TokenDisplayViewModel.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import CommonKit
import UIKit
import Combine

protocol TokenDisplayViewModelProtocol {
    func loadImage()
    
    var screenModel: TokenDisplayScreenModel { get }
    var screenModelPublisher: Published<TokenDisplayScreenModel>.Publisher { get }
}

final class TokenDisplayViewModel: TokenDisplayViewModelProtocol {
    private let networkManager: NetworkServiceProtocol
    private let coordinator: AlertErrorCoordinator & LoadingCoordinator
    private let taskManager: TaskManagerProtocol
    
    @Published private(set) var screenModel: TokenDisplayScreenModel
    var screenModelPublisher: Published<TokenDisplayScreenModel>.Publisher { $screenModel }
    
    init(networkManager: NetworkServiceProtocol,
         token: Token,
         coordinator: AlertErrorCoordinator & LoadingCoordinator,
         taskManager: TaskManagerProtocol = TaskManager()) {
        self.networkManager = networkManager
        self.coordinator = coordinator
        self.taskManager = taskManager
        self.screenModel = TokenDisplayScreenModel(token: token, image: nil)
    }
    
    func loadImage() {
        coordinator.showLoading(loading: true)
        taskManager.execute {
            do {
                let image = try await self.loadLargeImage()
                await MainActor.run { [weak self] in
                    self?.coordinator.showLoading(loading: false)
                    self?.screenModel.image = image
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.coordinator.showLoading(loading: false)
                    self?.presentError()
                }
            }
        }
    }
    
    deinit {
        taskManager.cancel()
    }
    
    private func loadLargeImage() async throws -> UIImage? {
        let request = TokenDisplayViewRequest(url: screenModel.token.largeImageURL)
        let dataImage: Data? = try await networkManager.executeRequest(request: request)
        guard let dataImage, let image = UIImage(data: dataImage) else {
            throw TokenDisplayError.imageParseError
        }
        return image
    }
    
    private func presentError() {
        let alertModel = AlertErrorModel(
            message: "Erro ao carregar a imagem do token.",
            secondaryButtonTitle: "Tentar novamente",
            primaryCompletion: nil,
            secondaryCompletion: { [weak self] in
                    self?.loadImage()
            }
        )
        coordinator.presentAlert(alertModel: alertModel)
    }
}
