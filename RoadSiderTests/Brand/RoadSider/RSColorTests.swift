//
//  RSColorTests.swift
//  RoadsiderTests
//
//  Created by Niyaz Ahmed Amanullah on 11/2/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import XCTest
@testable import Roadsider

class RSColorTests: XCTestCase {
    
    func test_brandColor_ShouldReturnMainBlue_whenStyleIsPrimary() {
        XCTAssertEqual(UIColor(red:0.09, green:0.28, blue:0.54, alpha:1.0), RSColor.brandColor(.primary))
    }
    
    func test_brandColor_shouldReturnOrangeColor_whenStyleIsSecondaray() {
        XCTAssertEqual(UIColor(red:0.95, green:0.56, blue:0.11, alpha:1.0), RSColor.brandColor(.secondary))
    }
    
    func test_brandColor_shouldReturnAuthorColor_whenStyleIsSecondaray1() {
        XCTAssertEqual(UIColor(red:0.50, green:0.66, blue:0.91, alpha:1.0), RSColor.brandColor(.secondary1))
    }
    
    func test_brandColor_shouldReturnlightSlateGray_whenStyleIsLightSlateGray() {
        XCTAssertEqual(UIColor(red:0.39, green:0.51, blue:0.67, alpha:1.0), RSColor.brandColor(.lightSlateGray))

    }
    
}


