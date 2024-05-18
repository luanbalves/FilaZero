//
//  ProfileCoordinator.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 16/05/24.
//

import Foundation
import UIKit
import SwiftUI

final class ProfileCoordinator {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeViewController() -> UIViewController {
        let view = ProfileView()
        let hostingVC = UIHostingController(rootView: view)
        hostingVC.title = "Perfil"
        return hostingVC
    }
}
