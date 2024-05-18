//
//  OrdersGateway.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 18/05/24.
//

import Foundation
import UIKit
import OrdersInterface

public struct OrdersGateway: OrdersInterface {
    public func makeOrdersModule(navigationController: UINavigationController?) -> UIViewController {
        let coordinator = OrdersCoordinator(navigationController: navigationController)
        return coordinator.makeViewController()
    }
    
    public init() {
        
    }
}
