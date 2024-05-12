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
    }
}
