//
//  RSHomeTabLayoutTests.swift
//  RoadsiderTests
//
//  Created by Niyaz Ahmed Amanullah on 11/2/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import XCTest
@testable import Roadsider

class RSVideosLayoutTests: XCTestCase {
   
    func test_tabIdentifier_ShouldReturnVideos() {
        let videoTab = RSVideosLayout(coordinator: RSDefaultCoordinatorMock(vc:nil))
        XCTAssertEqual("Videos", videoTab.tabIdentifier)
    }
    
    func test_tabBarItem_ShouldReturnVideosTitle() {
        let videoTab = RSVideosLayout(coordinator: RSDefaultCoordinatorMock(vc:nil))
        XCTAssertEqual("Videos", videoTab.tabBarItem().title)
    }
    
    func test_tabCoordinator_ShouldReturnVideosCoordinatorWithNilViewController() {
        let coordinator = RSDefaultCoordinatorMock(vc:nil)
        let videoTab = RSVideosLayout(coordinator:coordinator)
        XCTAssertNil(videoTab.tabViewController())
    }
    
    func test_tabViewController_ShouldReturnCoordinatorsViewController() {
        let videoTab = RSVideosLayout(coordinator: RSDefaultCoordinatorMock(vc:UIViewController()))
        XCTAssertNotNil(videoTab.tabViewController())
    }

}
