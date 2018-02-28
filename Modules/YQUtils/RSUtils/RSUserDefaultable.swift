//
//  RSUserDefaultable.swift
//  RSUtils
//
//  Created by Niyaz Ahmed Amanullah on 11/29/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//
import Foundation

// MARK: - Key Namespaceable
public protocol KeyNamespaceable { }

public extension KeyNamespaceable {
    private static func namespace(_ key: String) -> String {
        return "\(Self.self).\(key)"
    }
    
    static func namespace<T: RawRepresentable>(_ key: T) -> String where T.RawValue == String {
        return namespace(key.rawValue)
    }
}


// MARK: - Bool Defaults
public protocol BoolUserDefaultable : KeyNamespaceable {
    associatedtype BoolDefaultKey : RawRepresentable
}

public extension BoolUserDefaultable where BoolDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ bool: Bool, forKey key: BoolDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(bool, forKey: key)
    }
    
    // Get
    static func bool(forKey key: BoolDefaultKey) -> Bool {
        let key = namespace(key)
        return UserDefaults.standard.bool(forKey: key)
    }
}


// MARK: - Float Defaults
public protocol FloatUserDefaultable : KeyNamespaceable {
    associatedtype FloatDefaultKey : RawRepresentable
}

public extension FloatUserDefaultable where FloatDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ float: Float, forKey key: FloatDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(float, forKey: key)
    }
    
    // Get
    
    static func float(forKey key: FloatDefaultKey) -> Float {
        let key = namespace(key)
        return UserDefaults.standard.float(forKey: key)
    }
}


// MARK: - Integer Defaults
public protocol IntegerUserDefaultable : KeyNamespaceable {
    associatedtype IntegerDefaultKey : RawRepresentable
}

public extension IntegerUserDefaultable where IntegerDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ integer: Int, forKey key: IntegerDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(integer, forKey: key)
    }
    
    // Get
    
    static func integer(forKey key: IntegerDefaultKey) -> Int {
        let key = namespace(key)
        return UserDefaults.standard.integer(forKey: key)
    }
}

// MARK: - Integer Defaults
public protocol StringUserDefaultable : KeyNamespaceable {
    associatedtype StringDefaultKey : RawRepresentable
}

public extension StringUserDefaultable where StringDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ value: String, forKey key: StringDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    // Get
    
    static func string(forKey key: StringDefaultKey) -> String {
        let key = namespace(key)
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
}

// MARK: - Object Defaults
public protocol ObjectUserDefaultable : KeyNamespaceable {
    associatedtype ObjectDefaultKey : RawRepresentable
}

public extension ObjectUserDefaultable where ObjectDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ object: AnyObject, forKey key: ObjectDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(object, forKey: key)
    }
    
    // Get
    
    static func object(forKey key: ObjectDefaultKey) -> Any? {
        let key = namespace(key)
        return UserDefaults.standard.object(forKey: key)
    }
}


// MARK: - Double Defaults
public protocol DoubleUserDefaultable : KeyNamespaceable {
    associatedtype DoubleDefaultKey : RawRepresentable
}

public extension DoubleUserDefaultable where DoubleDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ double: Double, forKey key: DoubleDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(double, forKey: key)
    }
    
    // Get
    
    static func double(forKey key: DoubleDefaultKey) -> Double {
        let key = namespace(key)
        return UserDefaults.standard.double(forKey: key)
    }
}


// MARK: - URL Defaults
public protocol URLUserDefaultable : KeyNamespaceable {
    associatedtype URLDefaultKey : RawRepresentable
}

public extension URLUserDefaultable where URLDefaultKey.RawValue == String {
    // Set
    
    static func set(_ url: URL, forKey key: URLDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(url, forKey: key)
    }
    
    // Get
    
    static func url(forKey key: URLDefaultKey) -> URL? {
        let key = namespace(key)
        return UserDefaults.standard.url(forKey: key)
    }
}
