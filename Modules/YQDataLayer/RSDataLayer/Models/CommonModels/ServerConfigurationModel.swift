//
//  ServerConfigurationModel.swift
//  RSDataLayer
//
//  Created by Niyaz Ahmed Amanullah on 7/29/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation

/// Model for reading ServerConfigurationSettings from pList
public struct ServerConfigurationModel:Decodable {
    public let environment :String
    public let grantType : String
    public let urls: ServerConfigurationUrlInfo
    public let userName : String
    public let password: String
    enum CodingKeys: String, CodingKey {
        case urls = "Urls"
        case environment="Environment"
        case grantType="GrantType"
        case userName="Username"
        case password="Password"
    }
}

public struct ServerConfigurationUrlInfo :Decodable {
    public let baseUrl : String
    enum CodingKeys: String, CodingKey {
        case baseUrl = "RSBaseUrl"
    }
}
