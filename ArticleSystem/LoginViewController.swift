//
//  LoginViewController.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 26/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit
import ChameleonFramework

class LoginViewController: UIViewController {

    // MARK: Properties
    lazy var loginContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.flatBlue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(LandingButton.login.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()

    lazy var emailForLoginTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = TextFieldPlaceholder.email.rawValue
        tf.delegate = self
        return tf
    }()

    lazy var passwordForLoginTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = TextFieldPlaceholder.password.rawValue
        tf.delegate = self
        tf.isSecureTextEntry = true
        return tf
    }()

    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.greyPlaceholderColor()
        return view
    }()

    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.addSubview(loginContainerView)
        view.addSubview(loginRegisterButton)
        loginContainerView.addSubview(emailForLoginTextField)
        loginContainerView.addSubview(seperatorView)
        loginContainerView.addSubview(passwordForLoginTextField)

    }

    override func viewWillLayoutSubviews() {
        setupLoginContainerViewLayout()
        setupLoginRegisterButtonLayout()
    }

    // Change status bar color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

// Auto Layout functions
extension LoginViewController {
    func setupLoginContainerViewLayout() {
        loginContainerView.translatesAutoresizingMaskIntoConstraints = false
        loginContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loginContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.44).isActive = true
        loginContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true

        // EmailTextField
        emailForLoginTextField.translatesAutoresizingMaskIntoConstraints = false
        emailForLoginTextField.leftAnchor.constraint(equalTo: loginContainerView.leftAnchor, constant: 12).isActive = true
        emailForLoginTextField.topAnchor.constraint(equalTo: loginContainerView.topAnchor).isActive = true
        emailForLoginTextField.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        emailForLoginTextField.heightAnchor.constraint(equalTo: loginContainerView.heightAnchor, multiplier: 0.5).isActive = true

        // seperatorView
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.leftAnchor.constraint(equalTo: loginContainerView.leftAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: emailForLoginTextField.bottomAnchor).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true

        // PasswordForLoginTextField
        passwordForLoginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordForLoginTextField.leftAnchor.constraint(equalTo: loginContainerView.leftAnchor, constant: 12).isActive = true
        passwordForLoginTextField.topAnchor.constraint(equalTo: seperatorView.topAnchor).isActive = true
        passwordForLoginTextField.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        passwordForLoginTextField.bottomAnchor.constraint(equalTo: loginContainerView.bottomAnchor).isActive = true
    }

    func setupLoginRegisterButtonLayout() {
        loginRegisterButton.translatesAutoresizingMaskIntoConstraints = false
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: loginContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

enum LandingButton: String {
    case register = "Register"
    case login = "Login"
}

enum TextFieldPlaceholder: String {
    case email = "Email Address"
    case password = "Password"
}
