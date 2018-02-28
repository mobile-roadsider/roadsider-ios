//
//  RSMainAppLayoutTests.swift
//  RoadsiderTests
//
//  Created by Niyaz Ahmed Amanullah on 11/2/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import XCTest
@testable import Roadsider

class RSMainAppLayoutTests : XCTestCase {
    
    func test_MainAppLayoutTabs() {
        let mainAppLayout = RSMainAppLayout()
        XCTAssertEqual(2, mainAppLayout.orderedTabs.count)
    }
}
