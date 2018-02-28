//
//  RSSectionLayout.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import UIKit
/**
 Class for Section TabLayout
 - Parameters:
     - Coorindator: RSDefaultCoordinator that handles routing for the Section Tab Bar
 */
class RSSectionLayout<C:RSDefaultCoordinator> : RSTabLayout {
    
    let coordinator : C
    init(coordinator:C) {
        self.coordinator = coordinator
    }
    
    var tabIdentifier : String {
        return "Sections"
    }
    
    func tabBarItem() -> UITabBarItem {
        return UITabBarItem(title: tabIdentifier, image: UIImage(named: "SectionsTabUnselected.png")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SectionsTabSelected.png")?.withRenderingMode(.alwaysOriginal))
    }
    
    func tabViewController() -> UIViewController? {
        return self.coordinator.viewController
    }
    
    func tabViewCoordinator() -> RSCoordinator {
        return self.coordinator
    }
    
}
