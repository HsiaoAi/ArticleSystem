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

    lazy var containerViewController: UIViewController = {
        let viewController = LoginViewController()
        return viewController
    }()

    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: [UIColor.flatTeal, UIColor.flatNavyBlue])

        addChildViewController(containerViewController)
        view.addSubview(containerViewController.view)
        containerViewController.didMove(toParentViewController: self)

    }

    override func viewWillLayoutSubviews() {
        setupContainerViewLayout()
    }

    // Change status bar color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

// Auto Layout functions
extension LandingViewController {
    func setupContainerViewLayout() {
        containerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 2).isActive = true
        containerViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        containerViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true

    }
}

extension UIColor {
        class func greyPlaceholderColor() -> UIColor {
        return UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
    }
}
