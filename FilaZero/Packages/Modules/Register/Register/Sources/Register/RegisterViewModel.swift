//
//  RegisterViewModel.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 01/05/24.
//

import Foundation
import AuthServiceInterface

final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    private let authService: AuthServiceInterface
    @Published var selectedAccountType = "Cliente"

    init(authService: AuthServiceInterface)  {
        self.authService = authService
    }
    
    func signUp() {
        Task {
            do {
                try await authService.createUser(withEmail: email, password: password, fullname: fullname, accountType: selectedAccountType)
            } catch {
                print(error.localizedDescription)
                #warning("Fazer alerta de erro")
            }
        }
    }
}
