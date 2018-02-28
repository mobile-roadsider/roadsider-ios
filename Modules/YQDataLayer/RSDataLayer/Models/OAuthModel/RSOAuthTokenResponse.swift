//
//  RSOAuthResponse.swift
//  RSDataLayer
//
//  Created by Niyaz Ahmed Amanullah on 7/29/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation

/// OAuthResponse Model for deserialzing successful OAuth token Response
public struct RSOAuthTokenResponse : Codable {
    public let accessToken : String
    public let expires : Int
    public let tokenType : String
    public let scope: String
    public let refreshToken:String
    public init(accessToken : String , expires: Int, tokenType:String, scope:String,refreshToken:String) {
        self.accessToken = accessToken
        self.expires = expires
        self.tokenType = tokenType
        self.scope = scope
        self.refreshToken = refreshToken
    }
    enum CodingKeys:String, CodingKey {
        case accessToken = "access_token"
        case expires = "expires_in"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case scope
    }
}

extension RSOAuthTokenResponse: Equatable {
    static public func == (lhs: RSOAuthTokenResponse, rhs: RSOAuthTokenResponse) -> Bool {
        return
            lhs.accessToken == rhs.accessToken &&
                lhs.expires == rhs.expires &&
                lhs.tokenType == rhs.tokenType &&
                lhs.scope == rhs.scope &&
                lhs.refreshToken == rhs.refreshToken
    }
}
