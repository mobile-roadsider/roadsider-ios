//
//  TabLayout.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/21/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

// Protocol that each tab bar needs to confirm to
protocol RSTabLayout {
    var tabIdentifier : String {get}
    func tabBarItem() -> UITabBarItem
    func tabViewController() -> UIViewController?
    func tabViewCoordinator() -> RSCoordinator
}
