//
//  LoginViewModel.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 04/05/24.
//

import Foundation
import AuthServiceInterface

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    private let registerButtonPressed: () -> Void
    private let authService: AuthServiceInterface
    private let goToHome: () -> Void
    
    init(registerButtonPressed: @escaping () -> Void, authService: AuthServiceInterface, goToHome: @escaping () -> Void) {
        self.registerButtonPressed = registerButtonPressed
        self.authService = authService
        self.goToHome = goToHome
    }
    
    func didPressRegisterButton() {
        registerButtonPressed()
    }
    
    func signIn() {
        Task {
            do {
                try await authService.signIn(withEmail: email, password: password)
                goToHome()
            } catch {
                print(error.localizedDescription)
                #warning("Fazer o alerta de erro.")
            }
        }
    }
}
