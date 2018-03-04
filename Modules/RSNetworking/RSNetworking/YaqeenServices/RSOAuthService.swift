//
//  RSOAuthService.swift
//  RSNetworking
//
//  Created by Niyaz Ahmed Amanullah on 7/29/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import Alamofire
import RSUtils
import RSDataLayer

public protocol RSOAuthHttpServiceProtocol : RSHttpServiceProtocol {
    func fetch(endPoint: RSHttpServiceEndpoint, completion: @escaping ( RSResultType<RSOAuthTokenResponse,RSError>) ->())
}

/**
  Service that handles WP OAuthToken
 */
public class RSOAuthService : RSOAuthHttpServiceProtocol {
    public typealias RSOAuthHttpResult<RSOAuthTokenResponse> = RSResultType<RSOAuthTokenResponse,RSError>
    fileprivate let apiClient : RSAPIClientProtocol
    
    public required init(apiClient : RSAPIClientProtocol = RSOAuthAPIClient()) {
        self.apiClient = apiClient
    }
    
    /**
     Fetches the WP OAuthToken
     - Parameter completion: Void block of type RSOAuthHttpResult handling Success and Error of the request
                                Success is an object of type RSOAuthResponse
                                Error is an object of type Error
    */
    public func fetch(endPoint: RSHttpServiceEndpoint, completion: @escaping (RSOAuthHttpResult<RSOAuthTokenResponse>) ->()) {
        self.apiClient.request(endPoint: endPoint) { (result : RSOAuthHttpResult<RSOAuthTokenResponse> ) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
