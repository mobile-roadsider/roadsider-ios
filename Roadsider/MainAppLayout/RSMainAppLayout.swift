//
//  RSMainAppLayout.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation

protocol RSMainAppLayoutProtocol {
    var parentCoordinator : RSCoordinatorDelegate? {get set}
    var orderedTabs :  [RSTabLayout] {get}
}

// Main Class that returns the supported tab bars for the Home Screen
class RSMainAppLayout : RSMainAppLayoutProtocol {
    
    var parentCoordinator: RSCoordinatorDelegate?
    var orderedTabs : [RSTabLayout] {
        get {
            return [
                RSHomeLayout(coordinator:RSHomeTabCoordinator(parentCoordinator:parentCoordinator)),
                RSProfileLayout(coordinator:RSProfileCoordinator(parentCoordinator:parentCoordinator))
            ]
        }
    }
}
