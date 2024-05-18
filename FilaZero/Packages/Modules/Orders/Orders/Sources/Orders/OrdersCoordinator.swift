//
//  OrdersCoordinator.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 18/05/24.
//

import Foundation
import SwiftUI
import UIKit

final class OrdersCoordinator {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeViewController() -> UIViewController {
        let view = OrdersView()
        let hostingVC = UIHostingController(rootView: view)
        hostingVC.title = "Pedidos"
        return hostingVC
    }
}
