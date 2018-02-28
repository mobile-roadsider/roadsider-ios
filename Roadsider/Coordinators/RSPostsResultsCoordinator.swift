//
//  RSPostsResultCoordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 1/13/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import Foundation
import RSNetworking

protocol RSPostsResultsCoordinatorDelegate : class {
    func postsResultsCoordinatorDidFinish(postResultsCoordinator: RSPostsResultsCoordinator)
}

// Home Tab Coordinator that creates the Home Controller and is responsible for routing from Home Tab
final class RSPostsResultsCoordinator : RSDefaultCoordinator {
    
    private(set) var viewModel : RSHomeTabViewModelProtocol
    var configuration: ((RSHomeTabViewController) -> ())?
    var navigationController: UINavigationController?
    
    var viewController : RSHomeTabViewController?
    weak var delegate : RSPostsResultsCoordinatorDelegate?
    
    fileprivate(set) var postDetailsCoordinator : RSPostDetailsCoordinator?

    init(sectionId:Int, navigationTitle:String, navigationController:UINavigationController?) {
        self.viewModel = RSHomeTabViewModel(service: RSPostsService(), sectionId:sectionId, fetchImmediately:true, navigationTitle:navigationTitle)
        self.viewModel.coordinatorDelegate = self
        self.navigationController = navigationController
        self.viewController = RSHomeTabViewController(viewModel:self.viewModel)
    }
    
    func start() {
        guard let viewController = self.viewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated:true)
    }
}

extension RSPostsResultsCoordinator: RSHomeTabViewModelCoordinatorDelegate {
    func homeTabViewModelDidFinish(postViewModel:RSPostViewModel) {
        self.postDetailsCoordinator = RSPostDetailsCoordinator(post:postViewModel, navigationController:self.viewController?.navigationController)
        postDetailsCoordinator?.delegate = self
        self.postDetailsCoordinator?.start()
    }
}

extension  RSPostsResultsCoordinator : RSPostDetailsCoordinatorDelegate {
    func postDetailsCoordinatorDidFinish() {
        self.postDetailsCoordinator = nil
    }
}

