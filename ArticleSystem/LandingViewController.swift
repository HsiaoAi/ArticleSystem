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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: [UIColor.flatTeal, UIColor.flatNavyBlue])
    }

}
