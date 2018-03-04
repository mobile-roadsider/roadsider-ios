//
//  RSHomeTabLayoutTests.swift
//  RoadsiderTests
//
//  Created by Niyaz Ahmed Amanullah on 11/2/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import XCTest
@testable import Roadsider

class RSSectionLayoutTests: XCTestCase {
   
    func test_tabIdentifier_ShouldReturnSections() {
        let sectionTab = RSSectionLayout(coordinator: RSDefaultCoordinatorMock(vc:nil))
        XCTAssertEqual("Sections", sectionTab.tabIdentifier)
    }
    
    func test_tabBarItem_ShouldReturnSectionsTitle() {
        let sectionTab = RSSectionLayout(coordinator: RSDefaultCoordinatorMock(vc:nil))
        XCTAssertEqual("Sections", sectionTab.tabBarItem().title)
    }
    
    func test_tabCoordinator_ShouldReturnSectionsCoordinatorWithNilViewController() {
        let coordinator = RSDefaultCoordinatorMock(vc:nil)
        let sectionTab = RSSectionLayout(coordinator:coordinator)
        XCTAssertNil(sectionTab.tabViewController())
    }
    
    func test_tabViewController_ShouldReturnCoordinatorsViewController() {
        let sectionTab = RSSectionLayout(coordinator: RSDefaultCoordinatorMock(vc:UIViewController()))
        XCTAssertNotNil(sectionTab.tabViewController())
    }

}
