//
//  Landing.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 26/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import Foundation
import UIKit

enum LandingButton: String {
    case register = "Register"
    case login = "Login"
}

enum TextFieldPlaceholder: String {
    case email = "Email Address"
    case password = "Password"
    case firstName = "First Name"
    case lastName = "Last Name"
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapToHideKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapToHideKeyboard.cancelsTouchesInView = false
        view.addGestureRecognizer(tapToHideKeyboard)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
