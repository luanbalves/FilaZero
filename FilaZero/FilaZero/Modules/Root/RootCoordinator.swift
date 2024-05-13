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
    private let authService: AuthServiceInterface
    
    init(navigationController: UINavigationController?, authService: AuthServiceInterface) {
        self.navigationController = navigationController
        self.authService = authService
    }
    
    @MainActor
    func makeInitialView() -> UIViewController {
        
        if authService.userSession != nil {
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

