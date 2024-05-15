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
        guard let items = tabBar.items else {
            return
        }
        
        let firstItem = items[0]
        firstItem.title = "Home"
        firstItem.image = UIImage(systemName: "house")
    }
}
