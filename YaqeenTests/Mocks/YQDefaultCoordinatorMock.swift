//
//  RSDefaultCoordinatorMock.swift
//  RoadsiderTests
//
//  Created by Niyaz Ahmed Amanullah on 11/2/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import Roadsider
import UIKit

class RSDefaultCoordinatorMock : RSDefaultCoordinator {
    var animated: Bool {
        return true
    }
    
    var delegate: RSCoordinatorDelegate? = nil
    
    typealias VC = UIViewController

    var viewController: UIViewController?
    
    init(vc:UIViewController?) {
        self.viewController = vc
    }
    
    func start() {
        
    }
    
    func stop() {
        
    }
    
    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?) {
        
    }

}
