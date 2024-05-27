//
//  HomeCoordinator.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 30/04/24.
//

import Foundation
import UIKit
import SwiftUI
import DependencyContainer
import StoreServicesInterface

final class HomeCoordinator {
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()
    
    func makeViewController() -> UIViewController {
        let storeServices = DC.shared.resolve(type: .singleInstance, for: StoreServicesInterface.self)
        let homeView = HomeView(
            viewModel: .init(
                storeServices: storeServices
            )
        )
        let hostingVC = UIHostingController(rootView: homeView)
        navigationController.setViewControllers([hostingVC], animated: false)
        return navigationController
    }
}
