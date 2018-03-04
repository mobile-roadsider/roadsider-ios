//
//  RSLoginViewController.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 11/12/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import RSUtils

enum LoginType :String{
    case signIn
    case signUp
}

class RSLoginViewController : UIViewController {

    var currentLoginType : LoginType
    var coordinator: RSLoginCoordinator?
    private(set) var viewModel : RSLoginViewModelProtocol
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(viewModel:RSLoginViewModelProtocol) {
        self.currentLoginType = .signIn
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewDelegate = self
        NotificationCenter.default.addObserver(self,
                                  selector: #selector(keyboardDidShow(notification:)),
                                  name: NSNotification.Name.UIKeyboardDidShow,
                                  object: nil)
        NotificationCenter.default.addObserver(self,
                                  selector: #selector(keyboardWillHide(notification:)),
                                  name: NSNotification.Name.UIKeyboardWillHide,
                                  object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private lazy var loginView : RSLoginView = {
        let login = RSLoginView()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.delegate = self
        self.scrollView.addSubview(login)
        return login
    }()
    
    private lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.definesPresentationContext = true
        setupConstraints()        
    }
    
    private func setupConstraints() {
        self.view.backgroundColor = RSColor.brandColor(.primary)
        var constraints = [NSLayoutConstraint]()
        constraints.append(self.loginView.alignVertically(toView: self.scrollView))
        constraints.append(self.loginView.alignHorizontally(toView: self.scrollView))
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            constraints.append(scrollView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0))
        } else {
            constraints.append(scrollView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0))
        }
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0))
        constraints.append(contentsOf: self.scrollView.layoutHorizontal(margin: 0))
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureViewForLoginSwitch() {
        switch self.currentLoginType {
        case .signIn :
            self.loginView.configureForSignIn()
        case .signUp:
            self.loginView.configureForSignUp()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func updateLoginType() {
        switch self.currentLoginType {
        case .signIn :
            self.currentLoginType = .signUp
        case .signUp:
            self.currentLoginType = .signIn
        }
    }
    
    @objc func keyboardDidShow(notification:NSNotification) {
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, self.loginView.frame.size.height, 0.0)
        adjustContentInsets(contentInsets: contentInsets)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        adjustContentInsets(contentInsets: .zero)
    }
    
    fileprivate func adjustContentInsets(contentInsets: UIEdgeInsets) {
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.loginView.frame.size.height+150)
    }
}

extension RSLoginViewController : RSLoginViewDelegate {
    
    //TODO: Make this reusable
    func forgotPasswordLabelTapped() {
        let alertController = UIAlertController(title: "Reset Password", message: "Please enter your E-Mail Address", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [weak self]
            alert -> Void in
            guard let textField = alertController.textFields?[0] else {
                return
            }
            self?.viewModel.forgotPassword(email: textField.text ?? "")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField { (textField : UITextField?) -> Void in
            textField?.placeholder = "Email Address"
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func signupLabelTapped() {
        self.updateLoginType()
        self.configureViewForLoginSwitch()
    }
    
    func signInButtonTapped() {
        let loginValues = (name:self.loginView.nameField.text ?? "",email:self.loginView.emailField.text ?? "", password:self.loginView.password.text ?? "")
        switch self.currentLoginType {
        case .signIn :
            self.viewModel.userLoginSubmitted(email:loginValues.email, password: loginValues.password)
        case .signUp:
            self.viewModel.userRegistrationSubmitted(name:loginValues.name, email:loginValues.email, password: loginValues.password)
        }
    }

    func skipButtonTapped() {
        self.viewModel.skipLoginOrRegistration()
    }
}


extension RSLoginViewController : RSLoginViewModelViewDelegate {
    func showAlert(_ authType: RSAlertType) {
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        var alertAction : (title:String,message:String)
        switch authType {
        case .firstName,
            .lastName:
            alertAction = (title: "Please Enter Your Full Name", message: "E.g Hashim Roadsider")
        case .email:
            alertAction = (title: "Invalid E-Mail Address", message: "Please enter valid e-mail address")
        case .password(let message):
            alertAction = (title: "Invalid Password", message: message)
        case .login:
            alertAction = (title:"We were unable to verify your credentials.",message:"Please try again. If you do not remember your password please proceed to the Forgot Password option.")
        case .register:
            alertAction = (title:"We were unable to register at this time",message:"Please try again after sometime")
        case .resetPasswordConfirmation(let message):
            alertAction = (title:"",message:message)
        }
        self.presentAlertController(title:alertAction.title, message:alertAction.message, actions:okAction)
    }

}

extension RSLoginViewController : RSCoordinated {
    
    func getCoordinator() -> RSCoordinator? {
        return coordinator
    }
    
    func setCoordinator(_ coordinator: RSCoordinator) {
        self.coordinator = coordinator as? RSLoginCoordinator
    }
}
