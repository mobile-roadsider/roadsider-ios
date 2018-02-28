//
//  RSHomeTabBarContainer.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSNetworking
import UIKit

/**
 Main Tab Controller which will comprise of all other tab view controllers
*/
class RSMainTabBarContainer : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RSColor.brandColor(.primary)
        UITabBar.appearance().barTintColor = UIColor.white
    }
}
