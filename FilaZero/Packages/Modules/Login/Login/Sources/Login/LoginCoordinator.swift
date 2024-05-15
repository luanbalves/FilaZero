//
//  LoginCoordinator.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 04/05/24.
//

import Foundation
import UIKit
import SwiftUI
import RegisterInterface
import DependencyContainer
import AuthServiceInterface
import HomeInterface

final class LoginCoordinator {
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()
    
    func makeViewController() -> UIViewController {
        let authService = DC.shared.resolve(type: .singleInstance, for: AuthServiceInterface.self)
        let view = LoginView(viewModel: .init(
            registerButtonPressed: pushRegisterView,
            authService: authService,
            goToHome: pushHomeView)
        )
        let hostingVC = UIHostingController(rootView: view)
        hostingVC.title = "Login"
        navigationController.setViewControllers([hostingVC], animated: false)
        return navigationController
    }
    
    func pushRegisterView() {
        let gateway = DC.shared.resolve(type: .closureBased, for: RegisterInterface.self)
        let registerView = gateway.makeRegisterModule(navigationController: navigationController)
        navigationController.pushViewController(registerView, animated: true)
    }
    
    func pushHomeView() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes
                                    .compactMap({ $0 as? UIWindowScene })
                                    .first(where: { $0.activationState == .foregroundActive }),
               let window = windowScene.windows.first {
                let gateway = DC.shared.resolve(type: .closureBased, for: HomeInterface.self)
                let homeViewController = gateway.makeHomeModule()
                let tabBarController = RootTabBarController(viewControllers: [homeViewController])
                window.rootViewController = tabBarController
            }
        }
    }
}
