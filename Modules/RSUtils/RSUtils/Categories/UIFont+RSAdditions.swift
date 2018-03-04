//
//  UIFont+RSAdditions.swift
//  RSUtils
//
//  Created by Niyaz Ahmed Amanullah on 10/25/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

extension UIFont {
    /**
     Returns a UIFont for given name and Size. return default font if the given font does not exists
     - Parameters:
         - name: Name of the font
         - size: fond size
     - Returns : UIFont of given name and size or Default system font
     */
    public class func safeFont(withName name: String?, size: CGFloat) -> UIFont {
        guard let name = name else { return UIFont.preferredFont(forTextStyle:UIFontTextStyle.body) }
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
