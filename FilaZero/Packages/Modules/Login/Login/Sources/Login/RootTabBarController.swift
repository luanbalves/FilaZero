//
//  RootTabBarController.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 30/04/24.
//

import Foundation
import UIKit

public final class RootTabBarController: UITabBarController {
    
    public init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        setViewControllers(viewControllers, animated: false)
        updateTabBar()
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func updateTabBar() {
        guard tabBar.items != nil else {
            return
        }
        
        for (index, viewController) in viewControllers!.enumerated() {
            let title: String
            let imageName: String
            
            switch index {
            case 0:
                title = "Home"
                imageName = "house"
            case 1:
                title = "Pedidos"
                imageName = "pencil.and.list.clipboard"
            case 2:
                title = "Perfil"
                imageName = "person"
            default:
                continue
            }
            
            viewController.title = title
            viewController.tabBarItem.image = UIImage(systemName: imageName)
        }
    }
}
