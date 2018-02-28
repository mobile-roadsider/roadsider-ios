//
//  RSOAuthRequestTests.swift
//  RSNetworkingTests
//
//  Created by Niyaz Ahmed Amanullah on 9/9/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import XCTest
import Alamofire
@testable import RSNetworking

class RSOAuthRequestTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_fetchaccessToken_validParams() {
        let accessTokenRequest = RSOAuthRequest.fetchAccessToken(username: "username", password: "password")
        XCTAssertEqual(accessTokenRequest.httpMethod,.post,"Must be a Post Request")
        XCTAssertEqual(accessTokenRequest.path,"?oauth=token","path is incorrect")
        XCTAssertEqual(accessTokenRequest.parameters["username"] as! String,"username","username is incorrect")
        XCTAssertEqual(accessTokenRequest.parameters["password"] as! String,"password","password is incorrect")
        XCTAssertEqual(accessTokenRequest.parameters["grant_type"] as! String ,"password","granttype is incorrect")
        XCTAssertEqual(accessTokenRequest.baseUrl ,"https://Roadsiderinstitute.org","path is incorrect")
    }
    
    func test_fetchRefreshToken_validParams() {
        let refreshTokenRequest = RSOAuthRequest.fetchRefreshToken(username:"username", password:"password", refreshToken:"refreshToken")
        XCTAssertEqual(refreshTokenRequest.httpMethod,.post,"Must be a Post Request")
        XCTAssertEqual(refreshTokenRequest.path,"?oauth=token","path is incorrect")
        XCTAssertEqual(refreshTokenRequest.parameters["username"] as! String,"username","username is incorrect")
        XCTAssertEqual(refreshTokenRequest.parameters["password"] as! String,"password","password is incorrect")
        XCTAssertEqual(refreshTokenRequest.parameters["grant_type"] as! String ,"refresh_token","grant_type is incorrect")
        XCTAssertEqual(refreshTokenRequest.baseUrl ,"https://Roadsiderinstitute.org","base path is incorrect")
        XCTAssertEqual(refreshTokenRequest.fullURL ,"https://Roadsiderinstitute.org?oauth=token","full path is incorrect")
    }
}
