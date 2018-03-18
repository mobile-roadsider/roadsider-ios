//
//  AppCoordinator.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/21/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import UIKit
import RSUtils

// Main App Coordinator Which acts the the root router for the Entire App
class RSAppCoordinator : RSCoordinator {
    
    let window : UIWindow
    let appLayout : RSMainAppLayoutProtocol
    var tabCoordinator : RSTabBarCoordinator?
    var loginCoordinator : RSLoginCoordinator?
    init(window: UIWindow, appLayout: RSMainAppLayoutProtocol) {
        self.window = window
        self.appLayout = appLayout
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func start() {
        UINavigationBar.appearance().tintColor =  RSColor.brandColor(.secondary)
        UINavigationBar.appearance().barTintColor = RSColor.brandColor(.primary)
        UINavigationBar.appearance().barStyle = .blackOpaque
        UINavigationBar.appearance().isTranslucent = false
        if UserDefaults.Authentication.bool(forKey: .isLoggedIn) {
            let tabBarController = RSMainTabBarContainer()
            window.rootViewController = tabBarController
            setMainTabCoordinator()
        } else {
            loginCoordinator = RSLoginCoordinator(viewModel:RSLoginViewModel())
            loginCoordinator?.coordinatorDelegate = self
            loginCoordinator?.start()
        }
    }
    
    fileprivate func setMainTabCoordinator() {
        let tabBarController = RSMainTabBarContainer()
        window.rootViewController = tabBarController
        tabCoordinator = RSTabBarCoordinator(tabBarController:tabBarController,appLayout:self.appLayout)
        tabCoordinator?.start()
    }
}

extension RSAppCoordinator : RSLoginCoordinatorDelegate {
    func loginCoordinatorDidFinish(loginCoordinator: RSLoginCoordinator) {
        loginCoordinator.stop()
        setMainTabCoordinator()
    }
    
    func loginOrRegistrationSuccessful(loginCoordinator: RSLoginCoordinator) {
        NotificationCenter.default.post(Notification(name:RSNotificationConstants.kAuthenticationSuccessNotification))
        loginCoordinator.stopModally()
        setMainTabCoordinator()
    }
}

