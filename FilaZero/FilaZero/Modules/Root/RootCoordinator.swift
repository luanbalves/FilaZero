//
//  ViewController.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 30/04/24.
//

import Home
import UIKit
import FirebaseAuth
import Register
import Login
import AuthServices
import DependencyContainer
import AuthServiceInterface

final class RootCoordinator {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    @MainActor
    private func isUserLogged() -> Bool {
        let authService = DC.shared.resolve(type: .singleInstance, for: AuthServiceInterface.self)
        return authService.userSession != nil
    }
    
    @MainActor
    func makeInitialView() -> UIViewController {
        
        if isUserLogged() {
            let gateway = HomeGateway()
            let homeView = gateway.makeHomeModule()
            let tabBarController = RootTabBarController(viewControllers: [homeView])
            return tabBarController
        } else {
            let gateway = LoginGateway()
            let loginView = gateway.makeLoginModule()
            return loginView
        }
    }
}

