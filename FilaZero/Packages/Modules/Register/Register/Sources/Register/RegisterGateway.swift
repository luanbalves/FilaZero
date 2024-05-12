//
//  RegisterGateway.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 01/05/24.
//

import Foundation
import UIKit
import RegisterInterface

public struct RegisterGateway: RegisterInterface {
    public init() {
        
    }
    
    public func makeRegisterModule(navigationController: UINavigationController?) -> UIViewController {
        let coordinator = RegisterCoordinator(navigationController: navigationController)
        return coordinator.makeViewController()
    }
}
