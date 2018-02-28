//
//  RSAuthenticationUserDefaults.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 11/29/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSUtils

extension UserDefaults {
    struct Authentication : BoolUserDefaultable {
        private init() {}
        enum BoolDefaultKey :String {
            case isLoggedIn = "RSUserLoggedIn"
        }
    }
    
    struct ClientConfiguration : BoolUserDefaultable {
        private init() {}
        enum BoolDefaultKey :String {
            case isWelcomeAlertDisplayed
        }
    }

    
    struct Profile : StringUserDefaultable {
        private init() {}
        enum StringDefaultKey :String {
            case email
            case name
        }
    }

}
