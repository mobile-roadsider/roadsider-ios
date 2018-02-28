//
//  RSProfileCoordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 12/10/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import UIKit
import RSUtils

class RSProfileCoordinator : RSDefaultCoordinator {
    var viewController : RSProfileViewController?
    var loginCoordinator : RSLoginCoordinator?
    private(set) var viewModel : RSProfileViewModelProtocol
    
    let parentCoordinator : RSCoordinatorDelegate?
    init(parentCoordinator : RSCoordinatorDelegate?) {
        self.parentCoordinator = parentCoordinator
        viewModel = RSProfileViewModel()
        self.viewModel.coordinatorDelegate = self
    }

    func start() {
        self.viewController = RSProfileViewController(viewModel:viewModel)
    }
    
    var delegate: RSCoordinatorDelegate? {
        return self.parentCoordinator
    }
}

extension RSProfileCoordinator: RSProfileViewModelCoordinatorDelegate {
    func signoutUser() {
        self.loginCoordinator = RSLoginCoordinator(viewModel:RSLoginViewModel())
        loginCoordinator?.coordinatorDelegate = self
        loginCoordinator?.navigationController = self.viewController?.navigationController
        loginCoordinator?.startModally()
    }

    func showLogin() {
        self.loginCoordinator = RSLoginCoordinator(viewModel:RSLoginViewModel())
        loginCoordinator?.coordinatorDelegate = self
        loginCoordinator?.navigationController = self.viewController?.navigationController
        loginCoordinator?.startModally()
    }
}

extension RSProfileCoordinator : RSLoginCoordinatorDelegate {
    func loginCoordinatorDidFinish(loginCoordinator: RSLoginCoordinator) {
        loginCoordinator.stopModally()
        self.delegate?.willStop(in: self)
    }

    func loginOrRegistrationSuccessful(loginCoordinator: RSLoginCoordinator) {
        NotificationCenter.default.post(Notification(name:RSNotificationConstants.kAuthenticationSuccessNotification))
        loginCoordinator.stopModally()
        self.delegate?.willStop(in: self)
    }

}


