//
//  RSColorStyle.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/25/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

// Protocol defining Brand Colors
protocol RSColorProtocol {
    static func brandColor(_ style: RSColorStyle) -> UIColor
}

// Enum defining different Color style supported
public enum RSColorStyle {
    case primary // Main Blue
    case secondary // orange
    case secondary1 // Author Color
    case lightSlateGray
}

class RSColor: RSColorProtocol {
    
    /**
     Returns the Color for the givien style
     - Parameter style: one supported Color style
     - Returns: UIColor for specified style
     */
    class func brandColor(_ style: RSColorStyle) -> UIColor {
        return self.createBrandColorForStyle(style)
    }
}
