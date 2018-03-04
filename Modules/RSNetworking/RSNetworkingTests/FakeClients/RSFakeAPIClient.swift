//
//  RSFakeAPIClient.swift
//  RSNetworkingTests
//
//  Created by Niyaz Ahmed Amanullah on 9/11/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import Alamofire
import RSUtils
@testable import RSNetworking

public class RSFakeAPIClient<T:Decodable> : NSObject {
    var mockResponse : RSResultType<T,RSError>? = nil
    func addResponse(mockResponse: RSResultType<T,RSError>) {
        self.mockResponse = mockResponse
    }
}

extension RSFakeAPIClient : RSAPIClientProtocol {
    
    public typealias RSFakeHTTPResponseType<T:Decodable> = RSResultType<T,RSError>

    public var sessionManager: SessionManager {
        let configuration = URLSessionConfiguration.default
        let sessionManager = SessionManager(configuration: configuration)
        return sessionManager
    }
    
    public func request<T:Decodable>(endPoint: RSHttpServiceEndpoint,  completion: @escaping (RSFakeHTTPResponseType<T>) -> ()) {
        let response = self.mockResponse as! RSFakeHTTPResponseType<T>
        switch response {
        case .success(let data):
            completion(.success(data))
            break
        case .error(let error):
            completion(.error(error))
            break
        }
    }
}
