//
//  RSKeyChain.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 8/26/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSUtils
// Protocol for adding and removing AuthToken Keychain Properties
public protocol RSAuthTokenKeychain {
    var accessToken : String? {get}
    var refreshToken : String? {get}
    func setTokens(accessToken : String, refreshToken :String) -> Bool
}

// Singleton Class For storing and accessing Roadsider Keychain properties
public class RSKeychain {
    public static let sharedInstance = RSKeychain()
    fileprivate let keychain : RSKeychainFacade
    
    init() {
        keychain = RSKeychainFacade(service: "com.Roadsider.keychain")
    }
    
    public func clearKeyChain(){
        keychain.removeObject(forKey: RSKeychain.accessTokenKey)
        keychain.removeObject(forKey: RSKeychain.refreshTokenKey)
    }
}

// MARK : Keychain accessors for AuthToken related properties
extension RSKeychain : RSAuthTokenKeychain {
    static let accessTokenKey = "accessToken"
    static let refreshTokenKey = "refreshToken"
    public var accessToken : String? {
        return keychain.string(forKey: RSKeychain.accessTokenKey)
    }
    
    public var refreshToken : String? {
        return  keychain.string(forKey: RSKeychain.refreshTokenKey)
    }
    
    public func setTokens(accessToken: String, refreshToken: String) -> Bool {
        guard setAccessToken(accessToken), setRefreshToken(refreshToken) else {
            return false
        }
        return true
    }
    func setAccessToken(_ accessToken : String) -> Bool {
        return keychain.setString(accessToken, forKey: RSKeychain.accessTokenKey)
    }
    
    func setRefreshToken(_ refreshToken :String) -> Bool {
        return keychain.setString(refreshToken, forKey: RSKeychain.refreshTokenKey)
    }

}
