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
    private let storeServices = DC.shared.resolve(type: .singleInstance, for: StoreServicesInterface.self)
    private var cartManager = CartManager()

    func makeViewController() -> UIViewController {
        let homeView = HomeView(
            viewModel: .init(
                storeServices: storeServices,
                goToStore: pushStoreView(_:),
                goToCart: pushCartView
            )
        )
            .environmentObject(cartManager)
        let hostingVC = UIHostingController(rootView: homeView)
        navigationController.setViewControllers([hostingVC], animated: false)
        return navigationController
    }
    
    func pushStoreView(_ selectedStore: Store) {
        let storeView = StoreView(viewModel: .init(storeServices: storeServices, selectedStore: selectedStore, cartManager: cartManager, goToCart: pushCartView)).environmentObject(cartManager)
        let hostingVC = UIHostingController(rootView: storeView)
        navigationController.pushViewController(hostingVC, animated: true)
    }
    
    func pushCartView() {
        let cartView = CartView(viewModel: .init(cartManager: cartManager)).environmentObject(cartManager)
        let hostingVC = UIHostingController(rootView: cartView)
        navigationController.present(hostingVC, animated: true)
    }
}
