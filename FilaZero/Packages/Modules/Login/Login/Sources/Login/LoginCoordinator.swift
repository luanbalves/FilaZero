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
            authService: authService)
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
}
