
//
//  RSRequestAdapterRetreiver.swift
//  RSNetworking
//
//  Created by Niyaz Ahmed Amanullah on 8/13/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import Alamofire

// Main class to refresh the Token when access token expires
public class RSOAuthHandler : RequestAdapter, RequestRetrier {
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void

    private let lock = NSLock()
    
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    private let refreshTokenEndpoint : RSHttpServiceEndpoint
    private let accessToken : String?
    private let refreshToken : String?
    private let completionBlock : ((String,String) -> ())?
    
    public init(accessToken:String,
                refreshToken:String,
                refreshTokenEndpoint:RSHttpServiceEndpoint,
                completion: ((String,String) -> ())?) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.refreshTokenEndpoint = refreshTokenEndpoint
        self.completionBlock = completion
    }
    
    public func adapt(_ urlRequest: URLRequest) -> URLRequest {
        guard let accessToken = self.accessToken else {
            print("access token is nil!")
            return urlRequest
        }
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("utf8", forHTTPHeaderField: "Accept-Charset")
        return urlRequest
    }
    
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        guard let refreshToken = self.refreshToken else {
            print("refresh token is nil!")
            return completion(false, 0.0)
        }
        print("token has expired, request new token!")
        lock.lock() ; defer { lock.unlock() }
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode != 200, request.retryCount < 2  {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, accessToken, refreshToken in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    
                    if let accessToken = accessToken, let refreshToken = refreshToken {
                        strongSelf.completionBlock?(accessToken,refreshToken)
                    }
                    
                    strongSelf.requestsToRetry.forEach { $0(succeeded, 3.0) }
                    strongSelf.requestsToRetry.removeAll()
                }
            }
        } else {
            completion(false, 0.0)
            self.isRefreshing = false
        }
    }
    
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        
        guard !isRefreshing else { return }
        isRefreshing = true
        let authService = RSOAuthService()
        authService.fetch(endPoint:refreshTokenEndpoint) {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let authResponse):
                completion(true,authResponse.accessToken, authResponse.refreshToken)
            case .error(let error):
                print("\(error)")
                completion(false,nil,nil)
            }
            strongSelf.isRefreshing = false
        }
    }
}

