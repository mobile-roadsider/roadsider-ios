//
//  RSHomeTabCoordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation

// Home Tab Coordinator that creates the Home Controller and is responsible for routing from Home Tab
final class RSHomeTabCoordinator : RSDefaultCoordinator {
    var viewController : RSHomeTabViewController?
    
    let parentCoordinator : RSCoordinatorDelegate?
    init(parentCoordinator : RSCoordinatorDelegate?) {
        self.parentCoordinator = parentCoordinator
        _ = RSKeychain.sharedInstance.accessToken != nil
    }
    
    func start() {
        self.viewController = RSHomeTabViewController()        
    }
    
    var delegate: RSCoordinatorDelegate? {
        return self.parentCoordinator
    }
}
