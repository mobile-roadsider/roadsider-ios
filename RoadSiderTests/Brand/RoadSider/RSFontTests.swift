//
//  RSFontTests.swift
//  RoadsiderTests
//
//  Created by Niyaz Ahmed Amanullah on 11/2/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import XCTest
@testable import Roadsider

class RSFontTests: XCTestCase {
    
    
    func test_brandFont_shouldReturnRegularFont_whenStyleIsRegular() {
        XCTAssertEqual(UIFont.init(name: "Montserrat-Regular", size: 12), RSFont.brandFont(.regular(size: 12)))
    }
    
    func test_brandFont_shouldReturnBoldFont_whenStyleIsBold() {
        XCTAssertEqual(UIFont.init(name: "Montserrat-Bold", size: 12), RSFont.brandFont(.bold(size: 12)))
    }
    
    func test_brandFont_shouldReturnLightFont_whenStyleIsLight() {
        XCTAssertEqual(UIFont.init(name: "Montserrat-Light", size: 12), RSFont.brandFont(.light(size: 12)))
    }
    
    func test_brandFont_shouldReturnSemiBoldFont_whenStyleIsSemiBold() {
        XCTAssertEqual(UIFont.init(name: "Montserrat-Semibold", size: 12), RSFont.brandFont(.semiBold(size: 12)))
    }
    
    func test_brandFont_shouldReturnExtraboldFont_whenStyleIsExtrabold() {
        XCTAssertEqual(UIFont.init(name: "Montserrat-Extrabold", size: 12), RSFont.brandFont(.extraBold(size: 12)))
    }
    
    func test_brandFont_shouldReturnSemiboldItalicFont_whenStyleIsSemiboldItalic() {
        XCTAssertEqual(UIFont.init(name: "Montserrat-SemiboldItalic", size: 12), RSFont.brandFont(.semiBoldItalic(size: 12)))
    }
    
    func test_brandFont_shouldReturnMediumFont_whenStyleIsMedium() {
        XCTAssertEqual(UIFont.init(name: "Montserrat-Medium", size: 12), RSFont.brandFont(.medium(size: 12)))
    }
    
}
