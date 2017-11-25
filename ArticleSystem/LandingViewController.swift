//
//  LandingViewController.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 26/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit
import ChameleonFramework

class LandingViewController: UIViewController {

    lazy var loginContainerViewController: UIViewController = {
        let viewController = LoginViewController()
        return viewController
    }()

    lazy var signupContainerViewController: UIViewController = {
        let viewController = SignupViewController()
        return viewController
    }()

    lazy var segmentedControl: UISegmentedControl = {
        let items = [LandingButton.login.rawValue, LandingButton.register.rawValue]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 5.0
        control.layer.borderColor = UIColor.flatGray.cgColor
        control.layer.borderWidth = 2
        control.backgroundColor = UIColor.flatWhite
        control.tintColor = UIColor.flatBlue

        control.addTarget(self, action: .switchContainerView, for: .valueChanged)

        return control
    }()

    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: [UIColor.flatTeal, UIColor.flatNavyBlue])

        self.view.addSubview(loginContainerViewController.view)
        self.view.addSubview(signupContainerViewController.view)
        view.addSubview(segmentedControl)

        // ContainerView init
        setupContainerView()

    }

    override func viewWillLayoutSubviews() {
        setupContainerViewLayout()
        setupSegmentedControlLayout()
    }

    // Change status bar color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

// Auto Layout functions
extension LandingViewController {
    func setupContainerViewLayout() {
        loginContainerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        loginContainerViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginContainerViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 2).isActive = true
        loginContainerViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        loginContainerViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true

        signupContainerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        signupContainerViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupContainerViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 2).isActive = true
        signupContainerViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        signupContainerViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
    }

    func setupSegmentedControlLayout() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: loginContainerViewController.view.topAnchor, constant: -12).isActive = true
        segmentedControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: loginContainerViewController.view.widthAnchor, constant: -24).isActive = true

    }
}
extension LandingViewController {
    func setupContainerView() {
        self.loginContainerViewController.view.alpha = 1
        self.signupContainerViewController.view.alpha = 0
    }

    @objc func switchContainerView(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.loginContainerViewController.view.alpha = 1
            self.signupContainerViewController.view.alpha = 0
        } else {
            self.loginContainerViewController.view.alpha = 0
            self.signupContainerViewController.view.alpha = 1
        }
    }
}

extension UIColor {
        class func greyPlaceholderColor() -> UIColor {
        return UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
    }
}

extension Selector {
    static let switchContainerView = #selector(LandingViewController.switchContainerView)
}
