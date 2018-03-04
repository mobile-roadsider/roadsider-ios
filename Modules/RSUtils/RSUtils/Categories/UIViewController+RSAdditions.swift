//
//  UIViewController+RSAdditions.swift
//  RSUtils
//
//  Created by Niyaz Ahmed Amanullah on 12/2/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

extension UIViewController {
    public func presentAlertController(title:String, message:String, actions:UIAlertAction..., completion:(()->Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        for action in actions {
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true, completion: completion)
    }
}

