//
//  RSHomeTabLayoutTests.swift
//  RoadsiderTests
//
//  Created by Niyaz Ahmed Amanullah on 11/2/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import XCTest
@testable import Roadsider

class RSHomeLayoutTests: XCTestCase {
   
    func test_tabIdentifier_ShouldReturnHome() {
        let homeTab = RSHomeLayout(coordinator: RSDefaultCoordinatorMock(vc:nil))
        XCTAssertEqual("Home", homeTab.tabIdentifier)
    }
    
    func test_tabBarItem_ShouldReturnHomeTitle() {
        let homeTab = RSHomeLayout(coordinator: RSDefaultCoordinatorMock(vc:nil))
        XCTAssertEqual("Home", homeTab.tabBarItem().title)
    }
    
    func test_tabCoordinator_ShouldReturnHomePassedCoordinatorWithNilViewController() {
        let coordinator = RSDefaultCoordinatorMock(vc:nil)
        let homeTab = RSHomeLayout(coordinator:coordinator)
        XCTAssertNil(homeTab.tabViewController())
    }
    
    func test_tabViewController_ShouldReturnCoordinatorsViewController() {
        let homeTab = RSHomeLayout(coordinator: RSDefaultCoordinatorMock(vc:UIViewController()))
        XCTAssertNotNil(homeTab.tabViewController())
    }

}
