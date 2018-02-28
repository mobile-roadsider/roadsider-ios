//
//  RSUtilityTests.swift
//  RSUtilsTests
//
//  Created by Niyaz Ahmed Amanullah on 12/17/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RSUtils

class RSUtilityTests : QuickSpec {
    
    // TODO: Do Data Driven Testing with complex Email inputs
    override func spec() {
        describe("Email Validity") {
            context("when email is empty") {
                it("return false") {
                    expect(RSUtility.isValidEmail("")) == false
                }
            }
            context("when email is incorrect format") {
                it("return false") {
                    expect(RSUtility.isValidEmail("Roadsideremail")) == false
                }
            }
            context("when email is correct format") {
                it("return true") {
                    expect(RSUtility.isValidEmail("Roadsideremail@example.com")) == true
                }
            }
            context("when email is has complex symbols") {
                it("return false") {
                    expect(RSUtility.isValidEmail("yaq#!2eenemail@example.com")) == false
                }
            }
        }
        
        describe("Password Validity") {
            context("when password is empty") {
                it("return false") {
                    let passwordValidity = RSUtility.isValidPassword("")
                    expect(passwordValidity.valid) == false
                }
            }
            context("when password is less than 6 letters") {
                it("return false") {
                    let passwordValidity = RSUtility.isValidPassword("ios1")
                    expect(passwordValidity.valid) == false
                }
            }
            context("when password 6 letters of just letters") {
                it("return false") {
                    let passwordValidity = RSUtility.isValidPassword("iostes")
                    expect(passwordValidity.valid) == false
                }
            }
            context("when password 6 letters of just numbers") {
                it("return false") {
                    let passwordValidity = RSUtility.isValidPassword("123456")
                    expect(passwordValidity.valid) == false
                }
            }
            context("when password greater than 6 letters of just numbers") {
                it("return false") {
                    let passwordValidity = RSUtility.isValidPassword("123467")
                    expect(passwordValidity.valid) == false
                }
            }
            context("when password greater than 6 letters of just numbers") {
                it("return false") {
                    let passwordValidity = RSUtility.isValidPassword("abcdefg")
                    expect(passwordValidity.valid) == false
                }
            }
            context("when password 6 letters of numbers and letters") {
                it("return true") {
                    let passwordValidity = RSUtility.isValidPassword("t3styq")
                    expect(passwordValidity.valid) == true
                }
            }
            context("when password greater than 6 letters of numbers and letters") {
                it("return true") {
                    let passwordValidity = RSUtility.isValidPassword("t3stRoadsider")
                    expect(passwordValidity.valid) == true
                }
            }
            
        }
    }
}
