//
//  AppDependencyConfigurer.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 01/05/24.
//

import DependencyContainer
import Foundation
import Register
import RegisterInterface
import LoginInterface
import Login
import AuthServices
import AuthServiceInterface
import HomeInterface
import Home
import ProfileInterface
import Profile
import OrdersInterface
import Orders

enum AppDependencyConfigurer {
    @MainActor static func configure() {
        
        //MARK: - Register View Registration
        let registerViewClosure: () -> RegisterInterface = {
            RegisterGateway()
        }
        DC.shared.register(type: .closureBased(registerViewClosure), for: RegisterInterface.self)
        
        //MARK: - Login View Registration
        let loginViewClosure: () -> LoginInterface = {
            LoginGateway()
        }
        DC.shared.register(type: .closureBased(loginViewClosure), for: LoginInterface.self)
        
        //MARK: - Auth Service Registration
        let authService = AuthService()
        DC.shared.register(type: .singlesInstance(authService), for: AuthServiceInterface.self)
        
        //MARK: - Home View Registration
        let homeViewClosure: () -> HomeInterface = {
            HomeGateway()
        }
        DC.shared.register(type: .closureBased(homeViewClosure), for: HomeInterface.self)
        
        //MARK: - Profile View Registration
        
        let profileViewClosure: () -> ProfileInterface = {
            ProfileGateway()
        }
        DC.shared.register(type: .closureBased(profileViewClosure), for: ProfileInterface.self)
        
        //MARK: - Orders View Registration
        
        let ordersViewClosure: () -> OrdersInterface = {
            OrdersGateway()
        }
        DC.shared.register(type: .closureBased(ordersViewClosure), for: OrdersInterface.self)
    }
}
