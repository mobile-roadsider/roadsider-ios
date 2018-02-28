//
//  RSFont.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 10/25/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit
import RSUtils


// Font Extension for Roadsider Brand
extension RSFont {
     class func createBrandFontForStyle(_ style: RSFontStyle) -> UIFont {
        switch style {
        case .regular(let size):
            return UIFont.safeFont(withName: "Montserrat-Regular", size:size)
        case .bold(let size):
            return UIFont.safeFont(withName: "Montserrat-Bold", size: size)
        case .light(let size):
            return UIFont.safeFont(withName: "Montserrat-Light", size: size)
        case .semiBold(let size):
            return UIFont.safeFont(withName: "Montserrat-Semibold", size: size)
        case .extraBold(let size):
            return UIFont.safeFont(withName: "Montserrat-Extrabold", size: size)
        case .semiBoldItalic(let size):
            return UIFont.safeFont(withName: "Montserrat-SemiboldItalic", size: size)
        case .medium(let size):
            return UIFont.safeFont(withName: "Montserrat-Medium", size: size)
        }
    }
}
