//
//  RSPostDetailsCoordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 1/5/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import UIKit

protocol RSPostDetailsCoordinatorDelegate : class {
    func postDetailsCoordinatorDidFinish()
}

final class RSPostDetailsCoordinator : RSPushCoordinator {
    var configuration: ((RSPostDetailsViewController) -> ())?
    var navigationController: UINavigationController?
    
    var viewController : RSPostDetailsViewController?
    
    weak var delegate : RSPostDetailsCoordinatorDelegate?
    private(set) var viewModel : RSPostDetailsViewModelProtocol
    
    init(post:RSPostViewModel, navigationController:UINavigationController?) {
        self.navigationController = navigationController
        self.viewModel = RSPostDetailsViewModel(viewModel:post)
        self.viewModel.coordinatorDelegate = self
        self.viewController = RSPostDetailsViewController(viewModel:viewModel)
    }
}

extension RSPostDetailsCoordinator :  RSPostDetailsViewModelCoordinatorDelegate {
    func postDetailsViewModelFinish() {
       delegate?.postDetailsCoordinatorDidFinish()
    }

}
