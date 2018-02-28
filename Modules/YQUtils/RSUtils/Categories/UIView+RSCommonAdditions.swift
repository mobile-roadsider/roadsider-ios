//
//  UIView+RSCommonAdditions.swift
//  RSUtils
//
//  Created by Niyaz Ahmed Amanullah on 11/11/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

extension UIView {
    public func roundedCorners(cornerRadius:CGFloat, borderColor: CGColor? = UIColor.white.cgColor, borderWidth:CGFloat = 0.0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
    }
}
