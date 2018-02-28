//
//  RSVideosLayout.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import UIKit

/**
 Class for Videos TabLayout
 - Parameters:
     - Coorindator: RSDefaultCoordinator that handles routing for the Videos Tab Bar
 */
class RSVideosLayout<C:RSDefaultCoordinator> : RSTabLayout {
    
    let coordinator : C
    init(coordinator:C) {
        self.coordinator = coordinator
    }
    
    var tabIdentifier : String {
        return "Videos"
    }
    
    func tabBarItem() -> UITabBarItem {
        return UITabBarItem(title: tabIdentifier, image: UIImage(named: "VideosTabUnselected.png"), selectedImage: UIImage(named: "VideosTabSelected.png"))
    }
    
    func tabViewController() -> UIViewController? {
        return self.coordinator.viewController
    }
    
    func tabViewCoordinator() -> RSCoordinator {
        return self.coordinator
    }
    
}

