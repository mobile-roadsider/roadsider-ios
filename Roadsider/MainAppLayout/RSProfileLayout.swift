//
//  RSProfileLayout.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 12/10/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit
/**
 Class for Profile TabLayout
 - Parameters:
 - Coorindator: RSDefaultCoordinator that handles routing for the Profile Tab 
 */
class RSProfileLayout<C:RSDefaultCoordinator> : RSTabLayout {
    
    let coordinator : C
    init(coordinator:C) {
        self.coordinator = coordinator
    }
    
    var tabIdentifier : String {
        return "Profile"
    }
    
    func tabBarItem() -> UITabBarItem {
        return UITabBarItem(title: tabIdentifier, image: UIImage(named: "ProfileUnSelected.png")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ProfileSelected.png")?.withRenderingMode(.alwaysOriginal))
    }
    
    func tabViewController() -> UIViewController? {
        return self.coordinator.viewController
    }
    
    func tabViewCoordinator() -> RSCoordinator {
        return self.coordinator
    }
    
}
