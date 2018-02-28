//
//  SectionsCoordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 12/24/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSNetworking
import RSUIKit

final class RSSectionsCoordinator : RSDefaultCoordinator {
    var viewController : RSSectionsViewController?
    fileprivate(set) var viewModel : RSSectionsViewModelProtocol
    fileprivate(set) var postResultsCoordinator : RSPostsResultsCoordinator?
    
    let parentCoordinator : RSCoordinatorDelegate?
    init(parentCoordinator : RSCoordinatorDelegate?) {
        self.parentCoordinator = parentCoordinator
        self.viewModel = RSSectionsViewModel()
    }
    
    func start() {
        viewModel.coordinatorDelegate = self
        self.viewController = RSSectionsViewController(viewModel:viewModel)
    }
    
    var delegate: RSCoordinatorDelegate? {
        return self.parentCoordinator
    }
}

extension RSSectionsCoordinator : RSSectionsViewModelCoordinatorDelegate {
    func sectionTapped(viewModel: RSSectionViewModel) {
        self.postResultsCoordinator = RSPostsResultsCoordinator(sectionId:viewModel.id, navigationTitle:viewModel.sectionName, navigationController:self.viewController?.navigationController)
        postResultsCoordinator?.delegate = self
        self.postResultsCoordinator?.start()
    }
}

extension RSSectionsCoordinator : RSPostsResultsCoordinatorDelegate {
    func postsResultsCoordinatorDidFinish(postResultsCoordinator: RSPostsResultsCoordinator) {
        
    }
}


