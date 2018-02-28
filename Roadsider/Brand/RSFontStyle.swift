//
//  RSBrandProtocol.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/25/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

// Protocol defining Brand Fonts
protocol RSFontProtocol {
    static func brandFont(_ type: RSFontStyle) -> UIFont
}


// Enum defining different font style supported
public enum RSFontStyle {
    case regular(size:CGFloat)
    case bold(size:CGFloat)
    case light(size:CGFloat)
    case semiBold(size:CGFloat)
    case extraBold(size:CGFloat)
    case semiBoldItalic(size:CGFloat)
    case medium(size:CGFloat)
}

// Main Class that conforms to the defined brand protocol
class RSFont: RSFontProtocol {
    
    /**
     Returns the Font for the givien style
    - Parameter style: one supported font style
    - Returns: UIFont for specified style
    */
    class func brandFont(_ style: RSFontStyle) -> UIFont {
        return self.createBrandFontForStyle(style)
    }
}


