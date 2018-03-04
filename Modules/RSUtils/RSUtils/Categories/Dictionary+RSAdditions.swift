//
//  Dictionary+RSAdditions.swift
//  RSUtils
//
//  Created by Niyaz Ahmed Amanullah on 2/11/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import Foundation


public extension Dictionary {

    /// Overwrites the key/value pairs from this dictionary with the duplicate key entries in the passed in dictionary.
    /// Eg, calling ["hello" : "world", "foo" : "bar"].merge(withDictionary: ["hello" : "goodbye"]) would mutate the original dictionary into ["hello" : "goodbye", "foo" : "bar"]
    ///
    /// - Parameter dictionary: The dictionary whose key/value pairs you want to use to overwrite this dictionary's key/value pairs when duplicates are found
    public mutating func merge(withDictionary dictionary: Dictionary) {
        for (key,value) in dictionary {
            updateValue(value, forKey: key)
        }
    }
}
