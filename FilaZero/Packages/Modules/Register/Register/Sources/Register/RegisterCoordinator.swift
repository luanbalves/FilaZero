//
//  RegisterCoordinator.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 01/05/24.
//

import Foundation
import UIKit
import SwiftUI

final class RegisterCoordinator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeViewController() -> UIViewController {
        let view = RegisterView(viewModel: .init())
        let hostingVC = UIHostingController(rootView: view)
        hostingVC.title = "Registro"
        return hostingVC
    }
}
