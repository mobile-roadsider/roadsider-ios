//
//  RSProfileLayoutTests.swift
//  RoadsiderTests
//
//  Created by Niyaz Ahmed Amanullah on 12/16/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import XCTest
@testable import Roadsider

class RSProfileLayoutTests: XCTestCase {

    func test_tabIdentifier_ShouldReturnSections() {
        let profileTab = RSProfileLayout(coordinator: RSDefaultCoordinatorMock(vc:nil))
        XCTAssertEqual("Profile", profileTab.tabIdentifier)
    }
    
    func test_tabBarItem_ShouldReturnSectionsTitle() {
        let profileTab = RSProfileLayout(coordinator: RSDefaultCoordinatorMock(vc:nil))
        XCTAssertEqual("Profile", profileTab.tabBarItem().title)
    }
    
    func test_tabCoordinator_ShouldReturnSectionsCoordinatorWithNilViewController() {
        let coordinator = RSDefaultCoordinatorMock(vc:nil)
        let profileTab = RSProfileLayout(coordinator:coordinator)
        XCTAssertNil(profileTab.tabViewController())
    }
    
    func test_tabViewController_ShouldReturnCoordinatorsViewController() {
        let profileTab = RSProfileLayout(coordinator: RSDefaultCoordinatorMock(vc:UIViewController()))
        XCTAssertNotNil(profileTab.tabViewController())
    }
}
