//
//  RSProfileViewController.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 12/10/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import UIKit
import RSUtils

class RSProfileViewController : UIViewController {
    
    private lazy var signInView : RSSignInButtonView = {
        let signIn = RSSignInButtonView()
        signIn.translatesAutoresizingMaskIntoConstraints = false
        signIn.delegate = self
        self.view.addSubview(signIn)
        return signIn
    }()
    
    
    private lazy var welcomeView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 2
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var versionStack : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 2
        self.view.addSubview(view)
        return view
    }()
    private lazy var welcomeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = RSFont.brandFont(.bold(size: 20))
        label.textAlignment = .center
        return label
    }()

    let viewModel : RSProfileViewModelProtocol
    init(viewModel:RSProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName:RSNotificationConstants.kAuthenticationSuccessNotification, object:nil, queue:nil, using:loginSuccessful)
        self.signInView.configureForSignOut(userLoggedIn: UserDefaults.Authentication.bool(forKey: .isLoggedIn))
        setWelcomeMessage()
        setVersionInfo()
        setupConstraints()
    }

    func setupView() {
        self.signInView.configureForSignOut(userLoggedIn: UserDefaults.Authentication.bool(forKey: .isLoggedIn))
        setWelcomeMessage()
        setVersionInfo()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupConstraints() {
        self.view.backgroundColor = RSColor.brandColor(.primary)
        var constraints = [NSLayoutConstraint]()
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            constraints.append(self.versionStack.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -5))
        } else {
            constraints.append(self.versionStack.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor, constant: -5))
        }
        constraints.append(contentsOf:self.signInView.layoutHorizontal(margin: 40))
        constraints.append(self.signInView.pinBottom(self.versionStack))
        constraints.append(contentsOf:self.welcomeView.layoutHorizontal(margin: 0))
        constraints.append(self.welcomeView.alignHorizontally(toView: self.view))
        constraints.append(contentsOf:self.versionStack.layoutHorizontal(margin: 0))
        NSLayoutConstraint.activate(constraints)
    }

    
    private func setWelcomeMessage(){
        let salamLabel = UILabel()
        salamLabel.translatesAutoresizingMaskIntoConstraints = false
        salamLabel.textColor = RSColor.brandColor(.secondary)
        salamLabel.font = RSFont.brandFont(.bold(size: 20))
        salamLabel.textAlignment = .center
        salamLabel.text = self.viewModel.salutation
        self.welcomeView.addArrangedSubview(salamLabel)
        
        welcomeLabel.text = self.viewModel.name
        self.welcomeView.addArrangedSubview(welcomeLabel)
    }
    
    private func setVersionInfo() {
        let versionLabel = UILabel()
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.textColor = .white
        versionLabel.font = RSFont.brandFont(.bold(size: 12))
        versionLabel.textAlignment = .center
        versionLabel.text = self.viewModel.version
        self.versionStack.addArrangedSubview(versionLabel)
        
        let copyRightLabel = UILabel()
        copyRightLabel.textColor = .white
        copyRightLabel.font = RSFont.brandFont(.bold(size: 10))
        copyRightLabel.textAlignment = .center
        copyRightLabel.text =  self.viewModel.copyRight
        self.versionStack.addArrangedSubview(copyRightLabel)
    }
}

extension RSProfileViewController : RSSignInButtonDelegate {
    func forgotPasswordLabelTapped() {
    }
    
    func signupLabelTapped() {
    }
    
    func signInButtonTapped() {
        if UserDefaults.Authentication.bool(forKey: .isLoggedIn) {

            let okAction = UIAlertAction(title: "Sign Out", style: .default) { action in
                self.viewModel.signOutUser()
                self.welcomeLabel.text = self.viewModel.name
                self.signInView.configureForSignOut(userLoggedIn: false)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            self.presentAlertController(title: "Are you sure you want to sign out?",
                                        message: "",
                                        actions:okAction,cancelAction)
        } else {
            self.viewModel.showLogin()

        }
    }
}

// MARK : Notification functions
extension RSProfileViewController {
    fileprivate func loginSuccessful(_ notification:Notification) {
        NotificationCenter.default.removeObserver(self, name: RSNotificationConstants.kAuthenticationSuccessNotification, object: nil)
        self.welcomeLabel.text = self.viewModel.name
        self.signInView.configureForSignOut(userLoggedIn: true)
    }
}


