//
//  RSTextField.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 11/18/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit

class RSTextField : UITextField {
    
    init(placeHolderText:String,image:UIImage?=nil, isSecureEntry:Bool=false, delegate: UITextFieldDelegate? = nil) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        setupLoginTextField(placeHolderText:placeHolderText,image:image, isSecureEntry: isSecureEntry)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLoginTextField(placeHolderText:String, image:UIImage?, isSecureEntry:Bool)  {
        setupStyle(placeHolderText:placeHolderText,isSecureEntry:isSecureEntry)
        setupLeftIcon(image:image)
        setupConstraints()
    }
    
    private func setupStyle(placeHolderText:String, isSecureEntry:Bool) {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        let attributedPlaceholder = NSAttributedString(string:placeHolderText, attributes: [NSAttributedStringKey.paragraphStyle: style,NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: RSFont.brandFont(.medium(size: 11)) ])
        self.attributedPlaceholder = attributedPlaceholder
        self.backgroundColor = RSColor.brandColor(.lightSlateGray)
        self.roundedCorners(cornerRadius: 15)
        self.isSecureTextEntry = isSecureEntry
        self.contentVerticalAlignment = .center
        self.tintColor = UIColor.white
        self.textColor = UIColor.white
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
        
    }
    
    private func setupLeftIcon(image:UIImage?) {
        let viewPadding = UIView(frame: CGRect(x: 25, y: 0, width: 0 , height: 19.44))
        let imageView = UIImageView(image: image)
        imageView.center = viewPadding.center
        imageView.image  = image
        viewPadding.addSubview(imageView)

        self.leftView = viewPadding
        self.leftViewMode = .always
    }
    
    private func setupConstraints() {
        self.makeHeight(40).isActive = true
        self.setContentCompressionResistancePriority(.defaultLow, for: UILayoutConstraintAxis.horizontal)
        self.setContentHuggingPriority(.defaultLow, for: UILayoutConstraintAxis.horizontal)
    }
    
    // placeholder position
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 50, dy: 0)
    }
    
    // text position
    override public func editingRect(forBounds  bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 50, dy: 0)
    }
}

