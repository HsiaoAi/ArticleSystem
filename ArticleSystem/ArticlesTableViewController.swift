//
//  ViewController.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 25/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit
import Firebase

class ArticlesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: .handleLogout)

        // If user is logged in or not
        if Auth.auth().currentUser?.uid == nil {
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: false)
        }
    }
}
extension ArticlesTableViewController {
    @objc func handleLogout() {

        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }

        let landingController = LandingViewController()
        present(landingController, animated: true, completion: nil)
    }
}
extension Selector {
    static let handleLogout = #selector(ArticlesTableViewController.handleLogout)
}
