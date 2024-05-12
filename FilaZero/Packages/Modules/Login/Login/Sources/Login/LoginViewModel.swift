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
    
    init(registerButtonPressed: @escaping () -> Void, authService: AuthServiceInterface) {
        self.registerButtonPressed = registerButtonPressed
        self.authService = authService
    }
    
    func didPressRegisterButton() {
        registerButtonPressed()
    }
    
    func signIn() {
        Task {
            do {
                try await authService.signIn(withEmail: email, password: password)
            } catch {
                print(error.localizedDescription)
                #warning("Fazer o alerta de erro.")
            }
        }
    }
}
