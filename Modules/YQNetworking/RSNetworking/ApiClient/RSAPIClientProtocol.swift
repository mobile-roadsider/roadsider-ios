//
//  RSAPIClientProtocol.swift
//  RSNetworking
//
//  Created by Niyaz Ahmed Amanullah on 7/26/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import Alamofire
import RSUtils

// Protocol that Each Roadsider Service should conform to
public protocol RSAPIClientProtocol {

    /// Alamofire SessionManager
    var sessionManager:SessionManager {get}
    
    /**
    Method that makes request asynchronously

     - Parameters:

       - endPoint: RSAPIClientProtocol object that specifies the information needed for making an request
       - completion: Completion Block that handles Success and Failures of the request
                    SuccessValue should conform to Decodable Protocol
    */
    func request<SuccessValue:Decodable>(endPoint: RSHttpServiceEndpoint,  completion: @escaping (RSResultType<SuccessValue,RSError>) -> ());
    
    func cancelRequest(endPoint: RSHttpServiceEndpoint)
}

// MARK: - Default Implementation for RSHttpApiClientProtocol
extension RSAPIClientProtocol {
    public typealias HTTPResponseType<T:Decodable> = RSResultType<T,RSError>
    
    public var sessionManager : SessionManager {
        return RSSharedSession.sharedSession
    }
    
    public func request<T:Decodable>(endPoint: RSHttpServiceEndpoint, completion: @escaping (HTTPResponseType<T>) -> () ) {
        sessionManager.request(endPoint).validate().responseData { response in
            do {
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let decodedValue = try decoder.decode(T.self, from: data)
                    completion(.success(decodedValue))
                case .failure(let error):
                    // Do not do any custom error handling for cancelled request
                    if error.localizedDescription != "cancelled" {
                        completion(.error(.customError("Error Fetching Data : \(error)")))
                    }
                }
            } catch let error {
                print("\(error)")
                completion(.error(.customError("Error Decoding Response:\(response)")))
            }
        }
    }
    
    public func cancelRequest(endPoint: RSHttpServiceEndpoint) {
        do {
            let urlRequest = try endPoint.asURLRequest()
            sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
                dataTasks.forEach {
                    if $0.originalRequest?.url?.absoluteString == urlRequest.url?.absoluteString {
                        $0.cancel()
                    }
                }
            }
        } catch {
            print("Error Cancelling request")
        }
       
    }
}

public class RSBaseApiClient : RSAPIClientProtocol {
    public init() {}
}
