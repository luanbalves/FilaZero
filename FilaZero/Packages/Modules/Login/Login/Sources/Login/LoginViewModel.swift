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
    @Published var selectedAccountType = "Cliente"
    
    init(registerButtonPressed: @escaping () -> Void, authService: AuthServiceInterface, goToHome: @escaping () -> Void) {
        self.registerButtonPressed = registerButtonPressed
        self.authService = authService
        self.goToHome = goToHome
        
        if let savedAccountType = UserDefaults.standard.selectedAccountType {
            self.selectedAccountType = savedAccountType
        }
    }
    
    func didPressRegisterButton() {
        registerButtonPressed()
    }
    
    func signIn() {
        Task {
            do {
                UserDefaults.standard.selectedAccountType = selectedAccountType
                try await authService.signIn(withEmail: email, password: password)
                print(selectedAccountType)
                goToHome()
            } catch {
                print(error.localizedDescription)
#warning("Fazer o alerta de erro.")
            }
        }
    }
}

extension UserDefaults {
    public enum Keys {
        public static let selectedAccountType = "selectedAccountType"
    }
    
    public var selectedAccountType: String? {
        get {
            return string(forKey: Keys.selectedAccountType)
        }
        set {
            set(newValue, forKey: Keys.selectedAccountType)
        }
    }
}
