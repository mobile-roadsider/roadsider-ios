//
//  RSSignInButtonView.swift
//  RSUIKit
//
//  Created by Niyaz Ahmed Amanullah on 11/11/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit
import RSUtils

protocol RSSignInButtonDelegate : NSObjectProtocol {
    func forgotPasswordLabelTapped()
    func signupLabelTapped()
    func signInButtonTapped()
}

class RSSignInButtonView : UIView {
    
    weak var delegate : RSSignInButtonDelegate?
    
    var loginType : LoginType
    
    // MARK: Lazy Vars
    private lazy var forgotPasswordLabel : UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .right
        button.setTitle(RSSignInButtonView.kForgotPasswordText,for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = RSFont.brandFont(.medium(size: 11))
        button.roundedCorners(cornerRadius: 0)
        addTapRecognizer(view:button,action: #selector(RSSignInButtonView.forgotLabelTapped))
        return button
    }()
    
    
    private lazy var signUpLabel : UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.setTitle(RSSignInButtonView.kNewSignUpText,for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = RSFont.brandFont(.medium(size: 11))
        button.roundedCorners(cornerRadius: 0)
        addTapRecognizer(view:button,action: #selector(RSSignInButtonView.signUpLabelTapped))
        return button
    }()
    
    private lazy var signInButton : UIButton = {
        let button = UIButton()
        button.setTitle(RSSignInButtonView.kSignInText,for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = RSColor.brandColor(.secondary)
        button.titleLabel?.font = RSFont.brandFont(.medium(size: 15))
        button.roundedCorners(cornerRadius: 8, borderColor: RSColor.brandColor(.secondary).cgColor, borderWidth: 0)
        button.makeHeight(48).isActive = true
        addTapRecognizer(view:button,action:  #selector(RSSignInButtonView.signInButtonTapped))
        return button
    }()
    
   private  lazy var labelStack : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .trailing
        return stackview
    }()
    
    private lazy var verticalStack : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackview)
        return stackview
    }()
    
    public init() {
        self.loginType = .signIn
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureForSignUp() {
        self.forgotPasswordLabel.isHidden = true
        self.signUpLabel.contentHorizontalAlignment = .center
        self.signInButton.setTitle(RSSignInButtonView.kSignUpText,for: .normal)
        self.signUpLabel.setTitle(RSSignInButtonView.kAlreadySignedUpText, for: .normal)
    }
    
    func configureForSignIn() {
        self.forgotPasswordLabel.isHidden = false
        self.signUpLabel.contentHorizontalAlignment = .left
        self.signInButton.setTitle(RSSignInButtonView.kSignInText,for: .normal)
        self.signUpLabel.setTitle(RSSignInButtonView.kNewSignUpText, for: .normal)
    }
    
    func configureForSignOut(userLoggedIn:Bool) {
        self.forgotPasswordLabel.isHidden = true
        self.signUpLabel.isHidden = true
        if userLoggedIn {
            self.signInButton.setTitle(RSSignInButtonView.kSignOutText,for: .normal)
        } else {
            self.signInButton.setTitle(RSSignInButtonView.kSignUpOrSignIn,for: .normal)
        }
    }
    

    private func setupView() {
        labelStack.addArrangedSubview(signUpLabel)
        labelStack.addArrangedSubview(forgotPasswordLabel)
        verticalStack.addArrangedSubview(signInButton)
        verticalStack.addArrangedSubview(labelStack)
        NSLayoutConstraint.activate(verticalStack.attachToSuperView())
    }
    
    private func addTapRecognizer(view:UIView,action: Selector?){
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tap)
    }
    
    //MARK :RSSignInButtonDelegate
    @objc func forgotLabelTapped(sender:UITapGestureRecognizer) {
        self.delegate?.forgotPasswordLabelTapped()
    }
    
    @objc func signUpLabelTapped(sender:UITapGestureRecognizer) {
        self.delegate?.signupLabelTapped()
    }
    
    @objc func signInButtonTapped(sender:UITapGestureRecognizer) {
        self.delegate?.signInButtonTapped()
    }
}


//MARK : RSSignInButtonView
extension RSSignInButtonView {
    static let kNewSignUpText = "New Here? Sign Up"
    static let kForgotPasswordText = "Forgot Password?"
    static let kAlreadySignedUpText = "Already have an Account?"
    static let kSignInText = "Sign In"
    static let kSignUpText = "Sign Up"
    static let kSignOutText = "Sign Out"
    static let kSignUpOrSignIn = "Sign In or Sign Up"
}


