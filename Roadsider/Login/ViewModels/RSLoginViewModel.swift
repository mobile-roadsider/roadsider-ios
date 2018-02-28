//
//  RSLoginViewModel.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 12/1/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import RSUtils
import Firebase
import RSNetworking

enum RSAlertType {
    case firstName
    case lastName
    case email
    case password(String)
    case login
    case register
    case resetPasswordConfirmation(String)
}

protocol RSLoginViewModelViewDelegate : class {
    func showAlert(_ authType:RSAlertType)
}

protocol RSLoginViewModelCoordinatorDelegate : class {
    func userLoginSuccessful()
    func userRegistrationSuccessful()
    func setServiceHandler()
    func skipLoginOrRegistration()
}

protocol RSLoginViewModelProtocol {
    var viewDelegate : RSLoginViewModelViewDelegate? {get set}
    var coordinatorDelegate : RSLoginViewModelCoordinatorDelegate? {get set}
    func userLoginSubmitted(email:String, password:String)
    func userRegistrationSubmitted(name:String, email:String, password:String)
    func forgotPassword(email:String)
    func skipLoginOrRegistration()
}


class RSLoginViewModel : RSLoginViewModelProtocol {
    weak var viewDelegate: RSLoginViewModelViewDelegate?
    weak var coordinatorDelegate: RSLoginViewModelCoordinatorDelegate?
    
    func userLoginSubmitted(email:String, password:String) {
        if validateEmail(email) && validatePassword(password) {
            authenticateUser(email:email, password: password)
        }
    }
    
    func userRegistrationSubmitted(name:String, email:String, password:String) {
        if validateName(name) && validateEmail(email) && validatePassword(password) {
            registerUser(name:name,email:email,password:password)
        }
    }
    
    func forgotPassword(email:String) {
        if validateEmail(email) {
            sendForgotPasswordInstructions(email:email)
        }
    }
    
    func skipLoginOrRegistration() {
        coordinatorDelegate?.skipLoginOrRegistration()
    }

    private func sendForgotPasswordInstructions(email:String){
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            self?.viewDelegate?.showAlert(.resetPasswordConfirmation(String(format:"An e-mail has been sent to %@. Please check your mail for password reset instructions.",email)))
        }
    }

    
    private func validateName(_ name:String) -> Bool {
        let nameComponents = name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        if nameComponents.first == nil {
            viewDelegate?.showAlert(.firstName)
            return false
        } else if nameComponents.count==1 || nameComponents.last == nil {
            viewDelegate?.showAlert(.lastName)
            return false
        }
        return true
    }
    
    private func validateEmail(_ email : String) -> Bool {
        guard RSUtility.isValidEmail(email) else {
            viewDelegate?.showAlert(.email)
            return false
        }
        return true
    }
    
    private func validatePassword(_ password:String) -> Bool {
        let passwordValidity = RSUtility.isValidPassword(password)
        guard passwordValidity.valid else {
            viewDelegate?.showAlert(.password(passwordValidity.requirementMessage))
            return false
        }
        return true
    }
    
    private func authenticateUser(email:String, password:String) {
        // Add Firebase code here
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                // TODO:  log the error
                self?.viewDelegate?.showAlert(.login)
            } else {
                print("Successful Login")
                self?.finishAuthentication(name:user?.displayName, email:user?.email)
                // Dimiss the Controller and move to Coordinator
                self?.coordinatorDelegate?.userLoginSuccessful()
            }
        }
    }
    
    private func registerUser(name:String, email:String, password:String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                // TODO:  log the error
                
                self?.viewDelegate?.showAlert(.register)
            } else {
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = name
                    changeRequest.commitChanges { commitError in
                        if commitError != nil {
                            // TODO:  log the error
                            self?.viewDelegate?.showAlert(.register)
                        } else {
                            print("Successful Registration")
                            // Log User successfully updated. Add tracking info
                            self?.finishAuthentication(name:user.displayName, email:user.email)
                            // Dimiss the Controller and move to Coordinator
                            self?.coordinatorDelegate?.userRegistrationSuccessful()
                        }
                    }
                }
            }
        }
    }
    
    private func finishAuthentication(name:String?, email:String?) {
        UserDefaults.Authentication.set(true, forKey:.isLoggedIn)
        UserDefaults.Profile.set(name ?? "", forKey:.name)
        UserDefaults.Profile.set(email ?? "", forKey:.email)
        if RSKeychain.sharedInstance.accessToken ==  nil {
            self.coordinatorDelegate?.setServiceHandler()
        }
    }
   
}
