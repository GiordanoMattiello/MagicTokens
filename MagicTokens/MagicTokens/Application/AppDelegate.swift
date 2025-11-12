//
//  AppDelegate.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 09/11/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindowProtocol = UIWindow(frame: UIScreen.main.bounds)
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupInitial()
        return true
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        UIInterfaceOrientationMask.portrait
    }
    
    // MARK: - Private Methods
    
    private func setupInitial() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.startApp()
    }
}

