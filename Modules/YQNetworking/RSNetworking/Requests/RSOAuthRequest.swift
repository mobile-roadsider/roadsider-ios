//
//  RSOAuthRequest.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 9/6/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Alamofire
import RSDataLayer

/**
 OAuthRequest Enum conforming to RSHttpServiceEndpoint protocol
 */
public enum RSOAuthRequest : RSHttpServiceEndpoint {
    case fetchAccessToken(username:String?, password:String?)
    case fetchRefreshToken(username:String?, password:String?, refreshToken:String?)
    public var httpMethod: HTTPMethod {
        switch self {
        case .fetchAccessToken,
             .fetchRefreshToken:
            return .post
        }
    }
    
    public var path : String {
        switch self {
        case .fetchAccessToken,
             .fetchRefreshToken:
            return "?oauth=token"
        }
    }
    
    public var parameters: Parameters {
        var body: Parameters = Parameters()
        switch self {
        case .fetchAccessToken(let username, let password):
            body["grant_type"] = GrantType.password.rawValue
            body["username"] = username
            body["password"] = password
            break
        case .fetchRefreshToken(let username, let password,let refreshToken) :
            body["grant_type"] = GrantType.refreshToken.rawValue
            body["username"] = username
            body["password"] = password
            body["refresh_token"] = refreshToken
            break
        }
        return body
    }
}
