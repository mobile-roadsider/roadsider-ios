//
//  RSLoginView.swift
//  RSUIKit
//
//  Created by Niyaz Ahmed Amanullah on 11/11/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit
import RSUtils

protocol RSLoginViewDelegate : NSObjectProtocol {
    func forgotPasswordLabelTapped()
    func signupLabelTapped()
    func signInButtonTapped()
}

public class RSLoginView : UIView {
    
    weak var delegate : RSLoginViewDelegate?

    
    // MARK : Lazy Vars
    lazy var nameField = RSTextField(placeHolderText:RSLoginView.kNameText, image: UIImage(named: "Profile"),delegate:self)
    lazy var emailField = RSTextField(placeHolderText:RSLoginView.kEmailText, image: UIImage(named: "Email"), delegate:self)
    lazy var password = RSTextField(placeHolderText:RSLoginView.kPasswordText, image:UIImage(named: "Password"),isSecureEntry:true, delegate : self)
    
    lazy var signInView : RSSignInButtonView = {
        let signIn = RSSignInButtonView()
        signIn.delegate = self
        return signIn
    }()
    
    private lazy var loginView : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 30
        self.addSubview(view)
        return view
    }()
    
    private lazy var brandLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(named: "BrandLogo")
        imageView.heightAnchor.constraint(equalToConstant: 50)
        return imageView
    }()
    
    private lazy var textFieldStack : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 5
        return stackview
    }()
    
    public init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureForSignUp() {
        self.nameField.isHidden = false
        
        if (self.emailField.isFirstResponder || self.password.isFirstResponder) && isTextEmpty(self.nameField) {
            self.nameField.becomeFirstResponder()
        }
        self.signInView.configureForSignUp()
    }
    
    func configureForSignIn() {
        setupTextFields()
        self.signInView.configureForSignIn()
    }
    
    private func isTextEmpty(_ textField:UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return true
        }
        return false
    }
    
    private func setupView() {
        textFieldStack.addArrangedSubview(nameField)
        textFieldStack.addArrangedSubview(emailField)
        textFieldStack.addArrangedSubview(password)
        setupTextFields()
        
        loginView.addArrangedSubview(brandLogo)
        loginView.addArrangedSubview(textFieldStack)
        loginView.addArrangedSubview(signInView)
        
        if #available(iOS 11.0, *) {
            loginView.setCustomSpacing(20, after: brandLogo)
        }
        
        NSLayoutConstraint.activate(loginView.attachToSuperView())
    }
    
    private func setupTextFields() {
        nameField.isHidden = true
    }
}

extension RSLoginView : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(self.nameField == textField) {
            self.emailField.becomeFirstResponder()
        } else if(self.emailField == textField) {
            self.password.becomeFirstResponder()
        } else {
            self.endEditing(true)
        }
        return true
    }
}
extension RSLoginView : RSSignInButtonDelegate {
    func forgotPasswordLabelTapped() {
        self.delegate?.forgotPasswordLabelTapped()
    }
    
    func signupLabelTapped() {
        self.delegate?.signupLabelTapped()
    }
    
    func signInButtonTapped() {
        self.delegate?.signInButtonTapped()
    }
}

//MARK : Static Consts
extension RSLoginView {
    static let kNameText = "Full Name"
    static let kEmailText = "Email Address"
    static let kPasswordText = "Password"
    static let kSkipText = "Skip"
}

