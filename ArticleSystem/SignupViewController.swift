//
//  SignupViewController.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 26/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: Properties
    lazy var signupContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.flatBlue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(LandingButton.register.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()

    lazy var firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = TextFieldPlaceholder.firstName.rawValue
        tf.delegate = self
        return tf
    }()

    lazy var lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = TextFieldPlaceholder.lastName.rawValue
        tf.delegate = self
        return tf
    }()

    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = TextFieldPlaceholder.email.rawValue
        tf.delegate = self
        return tf
    }()

    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = TextFieldPlaceholder.password.rawValue
        tf.delegate = self
        tf.isSecureTextEntry = true
        return tf
    }()

    lazy var seperatorViewOne: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.greyPlaceholderColor()
        return view
    }()

    lazy var seperatorViewTwo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.greyPlaceholderColor()
        return view
    }()

    lazy var seperatorViewThree: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.greyPlaceholderColor()
        return view
    }()

    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.addSubview(signupContainerView)
        view.addSubview(signupButton)
        signupContainerView.addSubview(firstNameTextField)
        signupContainerView.addSubview(lastNameTextField)
        signupContainerView.addSubview(emailTextField)
        signupContainerView.addSubview(passwordTextField)
        signupContainerView.addSubview(seperatorViewOne)
        signupContainerView.addSubview(seperatorViewTwo)
        signupContainerView.addSubview(seperatorViewThree)
    }

    override func viewWillLayoutSubviews() {
        setupSignupContainerViewLayout()
        setupSignupButtonLayout()
    }
}

// Auto Layout functions
extension SignupViewController {
    func setupSignupContainerViewLayout() {
        signupContainerView.translatesAutoresizingMaskIntoConstraints = false
        signupContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        signupContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        signupContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true

        // FirstNameTextField
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.leftAnchor.constraint(equalTo: signupContainerView.leftAnchor, constant: 12).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: signupContainerView.topAnchor).isActive = true
        firstNameTextField.widthAnchor.constraint(equalTo: signupContainerView.widthAnchor).isActive = true
        firstNameTextField.heightAnchor.constraint(equalTo: signupContainerView.heightAnchor, multiplier: 0.25).isActive = true

        // seperatorView
        seperatorViewOne.translatesAutoresizingMaskIntoConstraints = false
        seperatorViewOne.leftAnchor.constraint(equalTo: signupContainerView.leftAnchor).isActive = true
        seperatorViewOne.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor).isActive = true
        seperatorViewOne.widthAnchor.constraint(equalTo: signupContainerView.widthAnchor).isActive = true
        seperatorViewOne.heightAnchor.constraint(equalToConstant: 1).isActive = true

        // LastNameTextField
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.leftAnchor.constraint(equalTo: signupContainerView.leftAnchor, constant: 12).isActive = true
        lastNameTextField.topAnchor.constraint(equalTo: seperatorViewOne.bottomAnchor).isActive = true
        lastNameTextField.widthAnchor.constraint(equalTo: signupContainerView.widthAnchor).isActive = true
        lastNameTextField.heightAnchor.constraint(equalTo: signupContainerView.heightAnchor, multiplier: 0.25).isActive = true

        // seperatorView
        seperatorViewTwo.translatesAutoresizingMaskIntoConstraints = false
        seperatorViewTwo.leftAnchor.constraint(equalTo: signupContainerView.leftAnchor).isActive = true
        seperatorViewTwo.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor).isActive = true
        seperatorViewTwo.widthAnchor.constraint(equalTo: signupContainerView.widthAnchor).isActive = true
        seperatorViewTwo.heightAnchor.constraint(equalToConstant: 1).isActive = true

        // EmailTextField
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leftAnchor.constraint(equalTo: signupContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: seperatorViewTwo.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: signupContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: signupContainerView.heightAnchor, multiplier: 0.25).isActive = true

        // seperatorView
        seperatorViewThree.translatesAutoresizingMaskIntoConstraints = false
        seperatorViewThree.leftAnchor.constraint(equalTo: signupContainerView.leftAnchor).isActive = true
        seperatorViewThree.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        seperatorViewThree.widthAnchor.constraint(equalTo: signupContainerView.widthAnchor).isActive = true
        seperatorViewThree.heightAnchor.constraint(equalToConstant: 1).isActive = true

        // PasswordTextField
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leftAnchor.constraint(equalTo: signupContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: seperatorViewThree.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: signupContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: signupContainerView.heightAnchor, multiplier: 0.25).isActive = true
    }

    func setupSignupButtonLayout() {
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: signupContainerView.bottomAnchor, constant: 12).isActive = true
        signupButton.widthAnchor.constraint(equalTo: signupContainerView.widthAnchor).isActive = true
        signupButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
