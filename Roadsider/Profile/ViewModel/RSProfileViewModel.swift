//
//  RSProfileViewModel.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 12/16/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation

protocol RSProfileViewModelCoordinatorDelegate : class {
    func signoutUser()
    func showLogin()
}

protocol RSProfileViewModelProtocol {
    var coordinatorDelegate : RSProfileViewModelCoordinatorDelegate? {get set}
    var salutation : String {get}
    var version :  String {get}
    var copyRight: String {get}
    var name : String {get}
    func signOutUser()
    func showLogin()
}

class RSProfileViewModel : RSProfileViewModelProtocol {
    var salutation: String {
        return "As-salāmu ʿAlaykum"
    }
    
    var version: String {
        guard let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String, let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return ""
        }

        return String(format:"App Version %@ (%@)",appVersion, appBuildNumber)
    }
    
    var copyRight: String {
        let date = Date()
        let calendar = Calendar.current
        
        let year = String(calendar.component(.year, from: date))
        return String(format:"COPYRIGHT © %@. Roadsider INSTITUTE FOR ISLAMIC RESEARCH",year)
    }
    
    var name: String {
        return UserDefaults.Profile.string(forKey: .name).capitalized
    }
    
    weak var coordinatorDelegate: RSProfileViewModelCoordinatorDelegate?

    func signOutUser() {
        UserDefaults.Authentication.set(false, forKey:.isLoggedIn)
        UserDefaults.Profile.set("", forKey:.name)
        UserDefaults.Profile.set("", forKey:.email)
       // coordinatorDelegate?.signoutUser()
    }

    func showLogin() {
        UserDefaults.Authentication.set(false, forKey:.isLoggedIn)
        UserDefaults.Profile.set("", forKey:.name)
        UserDefaults.Profile.set("", forKey:.email)
        coordinatorDelegate?.showLogin()
    }
}

