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
import RSNetworking

// Main App Coordinator Which acts the the root router for the Entire App
class RSAppCoordinator : RSCoordinator {
    
    let window : UIWindow
    let appLayout : RSMainAppLayoutProtocol
    var tabCoordinator : RSTabBarCoordinator?
    var loginCoordinator : RSLoginCoordinator?
    var authTokenHandler : RSAuthServiceHandler?
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
        configureServiceTokenHandler()
        let tabBarController = RSMainTabBarContainer()
        window.rootViewController = tabBarController
        configureServiceTokenHandler()
        setMainTabCoordinator()
    }
    
    fileprivate func setMainTabCoordinator() {
        let tabBarController = RSMainTabBarContainer()
        window.rootViewController = tabBarController
        tabCoordinator = RSTabBarCoordinator(tabBarController:tabBarController,appLayout:self.appLayout)
        tabCoordinator?.start()
    }
    
    fileprivate func configureServiceTokenHandler() {
        authTokenHandler = RSAuthServiceHandler(authService: RSOAuthService())
        if let accessToken = RSKeychain.sharedInstance.accessToken, let refreshToken = RSKeychain.sharedInstance.refreshToken {
            authTokenHandler?.setupRefreshTokenConfiguration(accessToken:accessToken, refreshToken: refreshToken)
        } else {
            authTokenHandler?.setupAuthToken(username:ServerConfigurationHandler.sharedInstance.serverConfig?.userName,password:ServerConfigurationHandler.sharedInstance.serverConfig?.password)
        }
    }
}
