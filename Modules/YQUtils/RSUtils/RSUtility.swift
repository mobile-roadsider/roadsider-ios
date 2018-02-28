//
//  RSUtility.swift
//  RSUtils
//
//  Created by Niyaz Ahmed Amanullah on 12/2/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation

public class RSUtility {
    public class func isValidEmail(_ emailText :String?) -> Bool {
        guard let email = emailText else {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    /// Validates whether password is valid
    /// Passwords must have at least 6 characters and a mix of letters and numbers characters
    /// - Parameter password: password string
    /// - Returns: Boolean true if password is valid false otherwise
    public class func isValidPassword(_ password:String) -> (valid:Bool,requirementMessage:String) {
        let passwordRegex = "^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+){6,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES[c] %@", passwordRegex)
        let requirementMessage = "Password must contain a minimum of six characters with at least one uppercase letter and one number."
        let isValid = passwordTest.evaluate(with: password)
        return (valid:isValid,requirementMessage: isValid ? "" : requirementMessage)
    }
    /*
     * TODO: THIS IS THE IDEAL PASSWORD Strength we need to have in our app.
     
     let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@$#]).{8,}$"
     let passwordTest = NSPredicate(format:"SELF MATCHES[c] %@", passwordRegex)
     let requirementMessage = """
     Password must be minimum of 8 characters with :
     At least one upper case letter
     At least one lower case letter
     At least one digit
     At least one of special characters: !#@$)
     """
     */
}

