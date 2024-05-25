//
//  StoreHomeCoordinator.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 23/05/24.
//

import Foundation
import UIKit
import SwiftUI
import DependencyContainer
import StoreServicesInterface

final class StoreHomeCoordinator {
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()
    private let storeServices = DC.shared.resolve(type: .singleInstance, for: StoreServicesInterface.self)

    func makeViewController() -> UIViewController {
        let homeView = StoreHomeView(
            viewModel: .init(
                goToAddStore: pushAddStoreView,
                storeServices: storeServices
            )
        )
        let hostingVC = UIHostingController(rootView: homeView)
        navigationController.setViewControllers([hostingVC], animated: false)
        return navigationController
    }
    
    func pushAddStoreView() {
        let addStoreView = AddStoreView(
            viewModel: .init(
                goToAddStore: {},
                storeServices: storeServices
            )
        )
        let hostingVC = UIHostingController(rootView: addStoreView)
        navigationController.present(hostingVC, animated: true)
    }
}
