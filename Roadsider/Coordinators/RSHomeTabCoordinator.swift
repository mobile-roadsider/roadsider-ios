//
//  RSHomeTabCoordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSNetworking

// Home Tab Coordinator that creates the Home Controller and is responsible for routing from Home Tab
final class RSHomeTabCoordinator : RSDefaultCoordinator {
    var viewController : RSHomeTabViewController?
    private(set) var viewModel : RSHomeTabViewModelProtocol
    fileprivate(set) var postDetailsCoordinator : RSPostDetailsCoordinator?
    
    let parentCoordinator : RSCoordinatorDelegate?
    init(parentCoordinator : RSCoordinatorDelegate?) {
        self.parentCoordinator = parentCoordinator
        let accessTokenPresent = RSKeychain.sharedInstance.accessToken != nil
        self.viewModel = RSHomeTabViewModel(service: RSPostsService(), fetchImmediately:accessTokenPresent, navigationTitle:"Latest In Roadsider")
        self.viewModel.coordinatorDelegate = self
    }
    
    func start() {
        self.viewController = RSHomeTabViewController(viewModel:self.viewModel)        
    }
    
    var delegate: RSCoordinatorDelegate? {
        return self.parentCoordinator
    }
}

extension RSHomeTabCoordinator: RSHomeTabViewModelCoordinatorDelegate {
    func homeTabViewModelDidFinish(postViewModel:RSPostViewModel) {
        self.postDetailsCoordinator = RSPostDetailsCoordinator(post:postViewModel, navigationController:self.viewController?.navigationController)
        postDetailsCoordinator?.delegate = self
        self.postDetailsCoordinator?.start()
    }
}

extension  RSHomeTabCoordinator : RSPostDetailsCoordinatorDelegate {
    func postDetailsCoordinatorDidFinish() {
        self.postDetailsCoordinator = nil
    }
}

