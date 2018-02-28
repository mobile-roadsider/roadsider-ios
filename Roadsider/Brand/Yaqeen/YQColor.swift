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
            return UIColor(red:0.09, green:0.28, blue:0.54, alpha:1.0)
         case .secondary:
            return UIColor(red:0.95, green:0.56, blue:0.11, alpha:1.0)
        case .secondary1:
            return UIColor(red:0.50, green:0.66, blue:0.91, alpha:1.0)
        case .lightSlateGray:
            return UIColor(red:0.39, green:0.51, blue:0.67, alpha:1.0)
        }
    }
}
