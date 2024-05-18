//
//  ProfileGateway.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 16/05/24.
//

import Foundation
import UIKit
import ProfileInterface

public struct ProfileGateway: ProfileInterface {
    
    public func makeProfileModule(navigationController: UINavigationController?) -> UIViewController {
        let coordinator = ProfileCoordinator(navigationController: navigationController)
        return coordinator.makeViewController()
    }
    
    public init() {
        
    }

}
