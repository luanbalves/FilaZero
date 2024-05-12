//
//  LoginGateway.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 04/05/24.
//

import Foundation
import UIKit
import RegisterInterface
import LoginInterface

public struct LoginGateway: LoginInterface {
    public init() {
        
    }
    
    public func makeLoginModule() -> UIViewController {
        let coordinator = LoginCoordinator()
        return coordinator.makeViewController()
    }
}
