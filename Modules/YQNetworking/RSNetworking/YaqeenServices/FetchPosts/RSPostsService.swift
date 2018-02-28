//
//  RSHomeService.swift
//  RSNetworking
//
//  Created by Niyaz Ahmed Amanullah on 10/22/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSDataLayer
import RSUtils

public protocol RSPostsServiceProtocol : RSHttpServiceProtocol {
    func fetchPosts(endPoint: RSHttpServiceEndpoint, completion: @escaping (RSResultType<[RSPostsResponse],RSError>) ->())
}

public class RSPostsService : RSPostsServiceProtocol {
    
    fileprivate let apiClient : RSAPIClientProtocol
    
    public required init(apiClient : RSAPIClientProtocol = RSBaseApiClient()) {
        self.apiClient = apiClient
    }
    
    public func fetchPosts(endPoint: RSHttpServiceEndpoint, completion: @escaping (RSResultType<[RSPostsResponse], RSError>) -> ()) {
        self.apiClient.cancelRequest(endPoint: endPoint)
        self.apiClient.request(endPoint: endPoint) { (result : RSResultType<[RSPostsResponse], RSError> ) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .error(let error):
                completion(.error(error))
            }
        }
    }

}



