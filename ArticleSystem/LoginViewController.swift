//
//  LoginViewController.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 26/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class LoginViewController: UIViewController {

    // MARK: Properties
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.Customs.kiwi
        return indicator
    }()

    lazy var loginContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.Customs.kiwi
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(LandingButton.login.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.placeholder = TextFieldPlaceholder.email.rawValue
        tf.delegate = self
        return tf
    }()

    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = TextFieldPlaceholder.password.rawValue
        tf.autocapitalizationType = .none
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
        setupSubviews()

    }

    override func viewWillLayoutSubviews() {
        setupLoginContainerViewLayout()
        setuploginButtonLayout()
    }
}

// Set up UI functions
extension LoginViewController {
    func setupSubviews() {
        view.addSubview(loginContainerView)
        view.addSubview(loginButton)
        loginContainerView.addSubview(emailTextField)
        loginContainerView.addSubview(seperatorView)
        loginContainerView.addSubview(passwordTextField)
        loginContainerView.addSubview(activityIndicator)
        loginContainerView.bringSubview(toFront: activityIndicator)
    }
    func setupLoginContainerViewLayout() {
        loginContainerView.translatesAutoresizingMaskIntoConstraints = false
        loginContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loginContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.44).isActive = true
        loginContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true

        // EmailTextField
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leftAnchor.constraint(equalTo: loginContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: loginContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: loginContainerView.heightAnchor, multiplier: 0.5).isActive = true

        // seperatorView
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.leftAnchor.constraint(equalTo: loginContainerView.leftAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true

        // passwordTextField
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leftAnchor.constraint(equalTo: loginContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: seperatorView.topAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: loginContainerView.bottomAnchor).isActive = true

        // Activity Indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: loginContainerView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loginContainerView.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func setuploginButtonLayout() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: loginContainerView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
    }
}
extension LoginViewController {
    @objc func handleLogin() {
        guard let email = emailTextField.text, email.contains("@")
            else { print (LoginError.invalidEmail); return }
        guard let password = passwordTextField.text, password.characters.count > 5 else {
            print(LoginError.invalidPassword); return
        }
        self.activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password, completion: { (_, error) in

            if let error = error {
                print("Login error: \(error)")
                return
            }
            self.activityIndicator.stopAnimating()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            appDelegate.window!.rootViewController?.dismiss(animated: true, completion: nil)
        })
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

enum LoginError: Error {
    case invalidEmail
    case invalidPassword
}
