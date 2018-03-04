//
//  RSBaseAPIClient.swift
//  RSNetworking
//
//  Created by Niyaz Ahmed Amanullah on 9/9/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import Alamofire

public class RSOAuthAPIClient: RSAPIClientProtocol {

    public var sessionManager: SessionManager {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = RSOAuthRequestHandler()
        return sessionManager
    }
    
    public init() {}
}

/**
  OAuthHandler conforming to RequestAdapter to add custom headers on all OAuthRequests
 **/
class RSOAuthRequestHandler: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        let userPasswordString = "TVbdeszZdXcv8pYOuUNq8y7VK03jCCiwxtJMWiLa:gXFonDdSy0iHzqCkqGD3iWzQpiCmBnxRlcgJQtBp"
        let loginData = userPasswordString.data(using: String.Encoding.utf8)!
        let base64Credentials = loginData.base64EncodedString()
        urlRequest.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}
