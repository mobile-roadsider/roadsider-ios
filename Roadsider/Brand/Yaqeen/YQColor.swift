//
//  RSColor.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/25/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

// Color Extension for Roadsider Brand
extension RSColor {
    class func createBrandColorForStyle(_ style: RSColorStyle) -> UIColor {
        switch style {
        case .primary:
            return UIColor(red:0.32, green:0.58, blue:0.79, alpha:1.0)
         case .secondary:
            return UIColor(red:0.99, green:1.00, blue:1.00, alpha:1.0)
        case .secondary1:
            return UIColor(red:0.50, green:0.66, blue:0.91, alpha:1.0)
        case .lightBlue:
            return UIColor(red:0.97, green:0.98, blue:0.99, alpha:1.0)
        }
    }
}
