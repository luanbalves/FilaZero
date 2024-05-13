//
//  RegisterCoordinator.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 01/05/24.
//

import Foundation
import UIKit
import SwiftUI
import DependencyContainer
import AuthServiceInterface

final class RegisterCoordinator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeViewController() -> UIViewController {
        let authService = DC.shared.resolve(type: .singleInstance, for: AuthServiceInterface.self)
        let view = RegisterView(viewModel: .init(authService: authService))
        let hostingVC = UIHostingController(rootView: view)
        hostingVC.title = "Registro"
        return hostingVC
    }
}
