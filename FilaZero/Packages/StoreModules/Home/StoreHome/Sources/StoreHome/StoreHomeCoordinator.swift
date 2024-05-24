//
//  StoreHomeCoordinator.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 23/05/24.
//

import Foundation
import UIKit
import SwiftUI

final class StoreHomeCoordinator {
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()
    
    func makeViewController() -> UIViewController {
        let homeView = StoreHomeView()
        let hostingVC = UIHostingController(rootView: homeView)
        navigationController.setViewControllers([hostingVC], animated: false)
        return navigationController
    }
}
