//
//  StoreHomeGateway.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 23/05/24.
//

import Foundation
import UIKit
import StoreHomeInterface

public struct StoreHomeGateway: StoreHomeInterface {
    public init() {
        
    }
    
    public func makeStoreHomeModule() -> UIViewController {
        let coordinator = StoreHomeCoordinator()
        return coordinator.makeViewController()
    }
}
