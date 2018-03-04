//
//  RSKeychainFacadeTests.swift
//  RSUtilsTests
//
//  Created by Niyaz Ahmed Amanullah on 9/4/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import XCTest
@testable import RSUtils

func data(_ string: String) -> Data {
    return string.data(using: String.Encoding.utf8)!
}

func AssertSuccessfulWrite(ofData data: Data?, forKey key: String, inkeychainFacade keychainFacade: RSKeychainFacade?, file: StaticString = #file, line: UInt = #line) {
    let read = keychainFacade?.data(forKey: key)
    XCTAssertEqual(data, read, file: file, line: line)
}

class RSKeychainFacadeTests: XCTestCase {
    var keychainFacade: RSKeychainFacade?
    
    override func setUp() {
        super.setUp()
        keychainFacade = RSKeychainFacade(service: "com.Roadsider.RSKeychainFacade.tests")
        keychainFacade?.resetKeychain()
    }
    
    override func tearDown() {
        keychainFacade = nil
        super.tearDown()
    }
    
    func test_can_read_nil_data_for_unset_key() {
        let testKey = "test_can_read_nil_data_for_unset_key"
        
        XCTAssertNil(keychainFacade?.data(forKey: testKey))
    }
    
    func test_safe_to_remove_object_for_an_unset_key() {
        let testKey = "test_safe_to_remove_object_for_an_unset_key"
        
        keychainFacade?.removeObject(forKey: testKey)
    }
    
    func test_can_reset_keychain() {
        let values = [
            ("key1", data("value")),
            ("key2", data("yet another value")),
            ("key3", data("some other value"))
        ]
        
        for (key, data) in values {
            keychainFacade?.setData(data, forKey: key)
            
        }
        
        keychainFacade?.resetKeychain()
        
        for (key, _) in values {
            AssertSuccessfulWrite(ofData: nil, forKey: key, inkeychainFacade: keychainFacade)
        }
    }
    
    
    // MARK: Disable Tests
    // Below tests are disable as this cannot be run on Simulator. This has to be run on a device.
    func DISABLEDtest_can_write_string_to_keychain() {
        let testKey = "test_can_write_string_to_keychain"
        let testString = "Hello, world."
        
        keychainFacade?.setString(testString, forKey: testKey)
        let retreivedData = keychainFacade?.string(forKey: testKey)
        
        XCTAssertNotNil(retreivedData)
        
        AssertSuccessfulWrite(ofData: data(testString), forKey: testKey, inkeychainFacade: keychainFacade)
    }
    
    func DISABLEDtest_can_read_string_from_keychain() {
        let testKey = "test_can_read_string_From_keychain"
        let testString = "Hello, world."
        
        keychainFacade?.setString(testString, forKey: testKey)
        let retreived = keychainFacade?.string(forKey: testKey)
        
        XCTAssertNotNil(retreived)
        XCTAssertEqual(testString, retreived)
    }
    
    func DISABLEDtest_can_write_nsdata_to_keychain() {
        let testKey = "test_can_write_nsdata_to_keychain"
        let testString = "Hello, world."
        let testData = data(testString)
        
        keychainFacade?.setData(testData, forKey: testKey)
        AssertSuccessfulWrite(ofData: testData, forKey: testKey, inkeychainFacade: keychainFacade)
    }
    
    func DISABLEDtest_can_write_nscoding_compliant_object_to_keychain() {
        let testKey = "test_can_write_nscoding_compliant_object_to_keychain"
        let testObject = ["hello" : "world"] as NSDictionary
        
        keychainFacade?.set(testObject, forKey: testKey)
        
        
        AssertSuccessfulWrite(ofData: NSKeyedArchiver.archivedData(withRootObject: testObject), forKey: testKey, inkeychainFacade: keychainFacade)
    }
    
    
    func DISABLEDtest_can_update_items() {
        let testKey = "test_can_update_items"
        let testString = "Hello, world."
        let testUpdateString = "World, Hello."
        
        keychainFacade?.setString(testString, forKey: testKey)
        
        
        // Assert initial set worked
        AssertSuccessfulWrite(ofData: data(testString), forKey: testKey, inkeychainFacade: keychainFacade)
        
        // Set item for the same key
        keychainFacade?.setString(testUpdateString, forKey: testKey)
        
        // Assert the update worked
        AssertSuccessfulWrite(ofData: data(testUpdateString), forKey: testKey, inkeychainFacade: keychainFacade)
    }
    
    func DISABLEDtest_can_remove_object_for_key() {
        let testKey = "test_can_remove_object_for_key"
        let testObject = "Hello, world."
        
        keychainFacade?.setString(testObject, forKey: testKey)
        
        AssertSuccessfulWrite(ofData: data(testObject), forKey: testKey, inkeychainFacade: keychainFacade)
        
        keychainFacade?.removeObject(forKey: testKey)
        
        AssertSuccessfulWrite(ofData: nil, forKey: testKey, inkeychainFacade: keychainFacade)
    }
    
}
