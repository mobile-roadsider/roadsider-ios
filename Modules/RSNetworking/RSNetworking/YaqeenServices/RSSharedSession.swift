//
//  RSBaseService.swift
//  RSNetworking
//
//  Created by Niyaz Ahmed Amanullah on 8/27/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import Alamofire

public class RSSharedSession {
    
    // Default session manager for making all api requests.
    public static let sharedSession : SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let sessionManager = SessionManager(configuration: configuration)
        return sessionManager
    }()
}
