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
import ProfileInterface
import OrdersInterface
import StoreHome
final class RootCoordinator {
    
    private let navigationController: UINavigationController?
    private let authService: AuthServiceInterface
    private let accountType = UserDefaults.standard.selectedAccountType

    init(navigationController: UINavigationController?, authService: AuthServiceInterface) {
        self.navigationController = navigationController
        self.authService = authService
    }
    
    @MainActor
    func makeInitialView() -> UIViewController {
        
        if authService.userSession != nil {
            if accountType == "Cliente" {
                let gateway = HomeGateway()
                let homeView = gateway.makeHomeModule()
                
                let gateway1 = DC.shared.resolve(type: .closureBased, for: OrdersInterface.self)
                let ordersView = gateway1.makeOrdersModule(navigationController: self.navigationController)
                
                let gateway2 = DC.shared.resolve(type: .closureBased, for: ProfileInterface.self)
                let profileView = gateway2.makeProfileModule(navigationController: self.navigationController)
                
                let tabBarController = RootTabBarController(viewControllers: [homeView, ordersView, profileView])
                return tabBarController
            } else {
                let gateway = StoreHomeGateway()
                let homeView = gateway.makeStoreHomeModule()
                
                let tabBarController = StoreRootTabBarController(viewControllers: [homeView])
                return tabBarController
            }
            
        } else {
            let gateway = LoginGateway()
            let loginView = gateway.makeLoginModule()
            return loginView
        }
    }
}

