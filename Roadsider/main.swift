//
//  main.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 9/16/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? NSStringFromClass(TestingAppDelegate.self) : NSStringFromClass(RoadsiderAppDelegate.self)
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
UIApplicationMain(CommandLine.argc, args, nil, appDelegateClass)
