//
//  RSEndpoint.swift
//  RSNetworking
//
//  Created by Niyaz Ahmed Amanullah on 7/29/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Alamofire

/**
  RSHttpServiceEndpoint Which sets all the parameters needed for making request
 */
public protocol RSHttpServiceEndpoint : URLRequestConvertible {
    // CRUD operations that the request needs to make
    var httpMethod : HTTPMethod {get}
    
    // Base Url of the request
    var baseUrl : String {get}
    
    // The end point path to consume
    var path: String { get }
    
    // This the full url of the request along with the base url
    var fullURL: String { get }
    
    // Refers to the ParameterEncoding for CRUD operations
    var encoding: ParameterEncoding { get }
    
    // Query or Body parameters of the CRUD operations
    var parameters: Parameters { get }

    // Custom Headers for the request
    var headers: HTTPHeaders { get }
}

extension RSHttpServiceEndpoint {
    
    public var httpMethod : HTTPMethod {
        return .get
    }
    
    public var baseUrl : String {
        guard let baseUrl = ServerConfigurationHandler.sharedInstance.serverConfig?.urls.baseUrl else {
            return ""
        }
        return baseUrl
    }
    
    public var path : String {
        return ""
    }
    
    public var fullURL : String {
        return baseUrl + path
    }
    
    public var encoding: ParameterEncoding {
        return httpMethod == .get ? URLEncoding.default : JSONEncoding.default
    }
    
    // A lot of requests don't require parameters
    // so we just set them to be empty
    public var parameters: Parameters {
        return Parameters()
    }
    
    public var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    
    // MARK: URLRequestConvertible
   public func asURLRequest() throws -> URLRequest {
        let url = URL(string: fullURL)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}


