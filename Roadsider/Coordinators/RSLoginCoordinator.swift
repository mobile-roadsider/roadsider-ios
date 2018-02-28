//
//  RSLoginCoordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 11/12/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit
import RSNetworking

protocol RSLoginCoordinatorDelegate {
    func loginCoordinatorDidFinish(loginCoordinator: RSLoginCoordinator)
    func loginOrRegistrationSuccessful(loginCoordinator: RSLoginCoordinator)
}

class RSLoginCoordinator : RSDefaultCoordinator {
    
    var navigationController: UINavigationController?
    var destinationNavigationController: UINavigationController?
    
    var coordinatorDelegate : RSLoginCoordinatorDelegate?
    var viewController : RSLoginViewController?
    var authTokenHandler : RSAuthServiceHandler?
    var viewModel : RSLoginViewModelProtocol
    init(viewModel: RSLoginViewModelProtocol) {
        self.viewModel = viewModel
        self.viewModel.coordinatorDelegate = self
        self.viewController = RSLoginViewController(viewModel:self.viewModel)
    }
    
    func start() {
        self.navigationController = UINavigationController(rootViewController:self.viewController!)
        UIApplication.shared.delegate?.window??.rootViewController = navigationController
    }
    
    func startModally() {
        self.navigationController?.present(self.viewController!, animated: true, completion: nil)
    }

    func stopModally() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }

    var configuration: ((RSLoginViewController) -> ())? {
        return nil
    }
}

extension RSLoginCoordinator : RSLoginViewModelCoordinatorDelegate {
    func userLoginSuccessful() {
        coordinatorDelegate?.loginOrRegistrationSuccessful(loginCoordinator: self)
    }
    
    func userRegistrationSuccessful() {
        coordinatorDelegate?.loginOrRegistrationSuccessful(loginCoordinator: self)
    }

    func skipLoginOrRegistration() {
        coordinatorDelegate?.loginCoordinatorDidFinish(loginCoordinator: self)
    }
    
    func setServiceHandler() {
        configureServiceTokenHandler()
        coordinatorDelegate?.loginCoordinatorDidFinish(loginCoordinator: self)
    }
    
    fileprivate func configureServiceTokenHandler() {
        
        // Set up Service Token only when we do not have any access token. Otherwise use the existing token on login
        if let _ = RSKeychain.sharedInstance.accessToken {
            authTokenHandler = RSAuthServiceHandler(authService: RSOAuthService())
            authTokenHandler?.setupAuthToken(username:ServerConfigurationHandler.sharedInstance.serverConfig?.userName,password:ServerConfigurationHandler.sharedInstance.serverConfig?.password)
        }
    }
}
