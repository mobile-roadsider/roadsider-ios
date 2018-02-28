//
//  RSAuthServiceHandler.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 8/26/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSNetworking
import RSUtils
import RSDataLayer
import Crashlytics

class RSAuthServiceHandler {
    
    let oauthService : RSOAuthHttpServiceProtocol
    public init(authService : RSOAuthHttpServiceProtocol) {
        self.oauthService = authService
    }
    
    func setupAuthToken(username:String?, password:String?) {
        let endPoint = RSOAuthRequest.fetchAccessToken(username: username, password: password)
        self.oauthService.fetch(endPoint:endPoint) {(result) in
            switch result {
            case .success(let authResponse):
                print("\(authResponse)")
                _ = RSKeychain.sharedInstance.setTokens(accessToken: authResponse.accessToken, refreshToken:authResponse.refreshToken)
                self.setupRefreshTokenConfiguration(accessToken:authResponse.accessToken, refreshToken:authResponse.refreshToken)
                NotificationCenter.default.post(Notification(name:RSNotificationConstants.kAppStartedNotification))
                break
            case .error(let error):
                Crashlytics.sharedInstance().recordError(error)
            }
        }
    }
    
    
    fileprivate func clearAuthToken() {
        RSKeychain.sharedInstance.clearKeyChain()
    }
    
    func setupRefreshTokenConfiguration(accessToken:String, refreshToken:String) {
        let refreshTokenEndpoint = RSOAuthRequest.fetchRefreshToken(username:ServerConfigurationHandler.sharedInstance.serverConfig?.userName
            , password : ServerConfigurationHandler.sharedInstance.serverConfig?.password
            , refreshToken : refreshToken)
        let authHandler = RSOAuthHandler(accessToken:accessToken,
                                         refreshToken:refreshToken,
                                         refreshTokenEndpoint:refreshTokenEndpoint) {[weak self] (newAccessToken,newRefreshToken) in
                                            _ = RSKeychain.sharedInstance.setTokens(accessToken: newAccessToken, refreshToken: newRefreshToken)
                                            self?.setupRefreshTokenConfiguration(accessToken:newAccessToken, refreshToken:newRefreshToken)

        }
        RSSharedSession.sharedSession.adapter =  authHandler
        RSSharedSession.sharedSession.retrier = authHandler
    }
    
    fileprivate func postService() {
        let service = RSPostsService()
        service.fetchPosts(endPoint:RSPostRequest.fetchAllPost(query:RSPostQuery())) { (result) in
            switch result {
            case .success(let response):
                print("\(response)")
                break
            case .error(let error):
                // We will handle this once we have our app running with features. Do not want to spend time right now.
                print("\(error)")
                break
            }
        }
    }
}
