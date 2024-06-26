//
//  HomeGateway.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 30/04/24.
//

import Foundation
import UIKit
import HomeInterface

public struct HomeGateway: HomeInterface {
    public init() {
        
    }
    
    public func makeHomeModule() -> UIViewController {
        let coordinator = HomeCoordinator()
        return coordinator.makeViewController()
    }
}
