//
//  TabCoordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/21/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit
import Foundation

// Main Coordinator that creates and routes all Tab bar coodinators
final class RSTabBarCoordinator : RSCoordinator {
    
    let tabBarController : UITabBarController
    private(set) var appLayout : RSMainAppLayoutProtocol
    var tabsCoordinator : [RSCoordinator] = []
    init(tabBarController: UITabBarController, appLayout: RSMainAppLayoutProtocol) {
        self.tabBarController = tabBarController
        self.appLayout = appLayout
        self.appLayout.parentCoordinator = self
    }
    
    func start(){
        var viewControllers : [UIViewController] = []
        for tabLayout in self.appLayout.orderedTabs {
            let coordinator = tabLayout.tabViewCoordinator()
            coordinator.start()
            tabsCoordinator.append(coordinator)
            if let controller = tabLayout.tabViewController() {
                controller.tabBarItem = tabLayout.tabBarItem()
                viewControllers.append(controller)
            }
        }
        tabBarController.viewControllers = viewControllers.map {
            UINavigationController(rootViewController: $0)}
    }
}

extension RSTabBarCoordinator : RSCoordinatorDelegate {
    func willStop(in coordinator: RSCoordinator) {
        UIApplication.shared.delegate?.window??.rootViewController = tabBarController
        tabBarController.selectedIndex = 0
    }
    
    func didStop(in coordinator: RSCoordinator) {
        
    }
}
