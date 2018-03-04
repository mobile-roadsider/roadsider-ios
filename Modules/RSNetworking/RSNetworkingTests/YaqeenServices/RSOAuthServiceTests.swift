//
//  RSOAuthServiceTest.swift
//  RSNetworkingTests
//
//  Created by Niyaz Ahmed Amanullah on 9/11/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import XCTest
import RSDataLayer
import RSUtils

@testable import RSNetworking

class RSOAuthServiceTests: XCTestCase {
    
    func test_fetch_withValidRequest_whenreturnsSuccess() {
        
        //Given
        let apiClient = RSFakeAPIClient<RSOAuthTokenResponse>()
        let authResponse = RSOAuthTokenResponse(accessToken: "hello", expires: 0, tokenType: "Bear", scope: "hi", refreshToken: "refreshToken")
        let mockResponse = RSResultType<RSOAuthTokenResponse, RSError>.success(authResponse)
        apiClient.addResponse(mockResponse: mockResponse)
        
        // When
        let authService = RSOAuthService(apiClient:apiClient)
        
        // Then
        let expect = expectation(description: "AuthService fetch call")
        authService.fetch(endPoint: RSOAuthRequest.fetchAccessToken(username: "Roadsider", password: "password")) { (result : RSResultType<RSOAuthTokenResponse,RSError>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, authResponse)
                break
            default:
                XCTFail("Error retreiving AuthResponse")
            }
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                    return
            }
            XCTFail("Expectation failed with error \(error)")
        }
    }
    
    func test_fetch_withValidRequest_whenreturnsError() {
        
        //Given
        let apiClient = RSFakeAPIClient<RSOAuthTokenResponse>()
        let error = "Error fetching Data"
        let mockResponse = RSResultType<RSOAuthTokenResponse, RSError>.error(.customError(error))
        apiClient.addResponse(mockResponse: mockResponse)
        
        // When
        let authService = RSOAuthService(apiClient:apiClient)
        
        // Then
        let expect = expectation(description: "AuthService fetch call")
        authService.fetch(endPoint: RSOAuthRequest.fetchAccessToken(username: "Roadsider", password: "password")) { (result : RSResultType<RSOAuthTokenResponse,RSError>) in
            switch result {
            case .error(let data):
                XCTAssertNotNil(data)
                break
            default:
                XCTFail("Error retreiving AuthResponse")
            }
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }
            XCTFail("Expectation failed with error \(error)")
        }
    }

}
