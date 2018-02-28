//
//  File.swift
//  RSDataLayer
//
//  Created by Niyaz Ahmed Amanullah on 8/27/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation

// Different Grant Types available at word press
public enum GrantType : String {
    case password = "password"
    case refreshToken = "refresh_token"
    case clientCredentials = "client_credentials"
}
