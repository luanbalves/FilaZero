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
import CommonModels

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
                storeServices: storeServices,
                goToStore: pushStoreView(_:)
            )
        )
        let hostingVC = UIHostingController(rootView: homeView)
        navigationController.setViewControllers([hostingVC], animated: false)
        return navigationController
    }
    
    func pushStoreView(_ selectedStore: Store) {
        let storeView = StoreView(selectedStore: selectedStore)
        let hostingVC = UIHostingController(rootView: storeView)
        navigationController.pushViewController(hostingVC, animated: true)
    }
}
