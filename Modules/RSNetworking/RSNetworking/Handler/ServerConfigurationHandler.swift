//
//  ServerConfigurationHandler.swift
//  RSNetworking
//
//  Created by Niyaz Ahmed Amanullah on 7/29/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSDataLayer

/**
  Singleton Class that reads ServerConfigurations plist
 */
let kProductionKey = "Production"
let kServerConfigurationsKey = "ServerConfigurations"
public class ServerConfigurationHandler {
    public static let sharedInstance = ServerConfigurationHandler()
    var serverConfigurations = [String : ServerConfigurationModel]()
    convenience init() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "ServerConfigurationSettings", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any] else {
                fatalError("Could not load ServerConfigurationSettings, filepath may be incorrect.")
        }
        self.init(dictionary: dictionary)
    }
    
    init(dictionary: [String: Any]) {
        guard let serverConfigs = dictionary[kServerConfigurationsKey] as? [String:Any] else {
            return
        }
        setupServerConfigs(serverConfigs: serverConfigs)
    }
    
    func setupServerConfigs(serverConfigs:[String:Any]) {
        let pListDecoder = PropertyListDecoder()
        for (environment,value) in serverConfigs {
            do {
                let data = try PropertyListSerialization.data(fromPropertyList: value, format: PropertyListSerialization.PropertyListFormat.binary, options: 0)
                serverConfigurations[environment] = try pListDecoder.decode(ServerConfigurationModel.self, from: data)
            } catch {
                print("Error trying to convert data to ServerConfig for key \(environment)")
            }
        }
    }
    
    /// Variable that return the server configuration for particular environment
    public var serverConfig : ServerConfigurationModel? {
        guard let serverConfig = serverConfigurations[kProductionKey] else {
            return nil
        }
        return serverConfig
    }
    
}
