//
//  RSHomeLayout.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/21/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import UIKit

/**
 Class for Home TabLayout
 - Parameters:
     - Coorindator: RSDefaultCoordinator that handles routing for the Home Tab Bar
 */
class RSHomeLayout<C:RSDefaultCoordinator> : RSTabLayout {
    
    let coordinator : C
    init(coordinator:C) {
        self.coordinator = coordinator
    }

    var tabIdentifier : String {
        return "Home"
    }
    
    func tabBarItem() -> UITabBarItem {
        return UITabBarItem(title: tabIdentifier, image: UIImage(named: "HomeTabUnselected.png")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "HomeTabSelected.png")?.withRenderingMode(.alwaysOriginal))
    }
    
    func tabViewController() -> UIViewController? {
        return self.coordinator.viewController
    }
    
    func tabViewCoordinator() -> RSCoordinator {
        return self.coordinator
    }
    
}
