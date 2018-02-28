//
//  Coordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/21/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

// Base Coordinator protocol
public protocol RSCoordinator {
    /// Triggers navigation to the corresponding controller
    func start()
    
    /// Stops corresponding controller and returns back to previous one
    func stop()
    
    /// Called when segue navigation form corresponding controller to different controller is about to start and should handle this navigation
    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?)
}

/// Navigate and stop methods are optional
extension RSCoordinator {
    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?) {
    }
    
    func stop() {
    }
}

// MARK : RSDefaultCoordinator

// DefaultCoordinator conforming to RSCoordinator which supports Delegation
public protocol RSDefaultCoordinator: RSCoordinator {
    associatedtype VC: UIViewController
    var viewController: VC? { get set }
    
    var animated: Bool { get }
    weak var delegate: RSCoordinatorDelegate? { get }
}

extension RSDefaultCoordinator {
    // default implementation if not overriden
    var animated: Bool {
        get {
            return true
        }
    }
    
    // default implementation of nil delegate, should be overriden when needed
    weak var delegate: RSCoordinatorDelegate? {
        get {
            return nil
        }
    }
}

// MARK : RSPushCoordinator

// Coordinator for supporting Pushing and popoing the navigation controller
public protocol RSPushCoordinator: RSDefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController? { get }
}

extension RSPushCoordinator where VC: RSCoordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }
        
        configuration?(viewController)
        viewController.setCoordinator(self)
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func stop() {
        delegate?.willStop(in: self)
        navigationController?.popViewController(animated: animated)
        delegate?.didStop(in: self)
    }
}

// MARK : RSModalCoordinator

// Coordinator for supporting Presenting and Dismissing a Modal
public protocol RSModalCoordinator: RSDefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController { get }
    weak var destinationNavigationController: UINavigationController? { get }
}

extension RSModalCoordinator where VC: RSCoordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }
        
        configuration?(viewController)
        viewController.setCoordinator(self)
        
        if let destinationNavigationController = destinationNavigationController {
            // wrapper navigation controller given, present it
            navigationController.present(destinationNavigationController, animated: animated, completion: nil)
        } else {
            // no wrapper navigation controller given, present actual controller
            navigationController.present(viewController, animated: animated, completion: nil)
        }
    }
    
    func stop() {
        delegate?.willStop(in: self)
        viewController?.dismiss(animated: true, completion: {
            self.delegate?.didStop(in: self)
        })
    }
}

// MARK : RSCoordinatorDelegate

// Delegate that would define additional operation before stopping coordinator
public protocol RSCoordinatorDelegate: class {
    func willStop(in coordinator: RSCoordinator)
    func didStop(in coordinator: RSCoordinator)
}

// MARK : RSCoordinated

/// Used typically on view controllers to refer to it's coordinator
public protocol RSCoordinated {
    func getCoordinator() -> RSCoordinator?
    func setCoordinator(_ coordinator: RSCoordinator)
}
